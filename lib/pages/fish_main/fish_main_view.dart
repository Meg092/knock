import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:async';

import 'fish_main_logic.dart';

class FishMainPage extends StatefulWidget {
  const FishMainPage({super.key});

  @override
  State<FishMainPage> createState() => _FishMainPageState();
}

class _FishMainPageState extends State<FishMainPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  FishMainLogic controller = Get.find();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();
  final List<String> _soundOptions = [
    'assets/voice0.mp3',
    'assets/voice1.mp3',
    'assets/voice2.mp3',
    'assets/voice3.mp3'
  ];

  final List<String> _bgmOptions = [
    'No background music',
    'assets/bg1.mp3',
    'assets/bg2.mp3',
    'assets/bg3.mp3',
    'assets/bg4.mp3',
    'assets/bg5.mp3',
    'assets/bg6.mp3',
  ];

  int _selectedSoundIndex = 0;
  int _selectedBigImgIndex = 0;
  int _selectedBgmIndex = 0;
  bool _isAutoMode = false;
  bool _isBgmPlaying = false;
  double _interval = 1.0;
  double _totalDuration = 60 * 30;
  int _meritCount = 0;
  AnimationController? _animationController;
  Timer? _autoTimer;
  Duration _elapsedTime = Duration.zero;
  Duration _remainingTime = Duration.zero;
  final GlobalKey _fishKey = GlobalKey();
  final List<MeritText> _meritTexts = [];

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final nowKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _meritCount = prefs.getInt(nowKey) ?? 0;
    _selectedBigImgIndex = prefs.getInt('bgImg') ?? 0;
    _selectedSoundIndex = prefs.getInt('voice') ?? 0;
    _isAutoMode = (prefs.getInt('style') ?? 1) == 1 ? true : false;
    _interval = (prefs.getInt('intervalDuration') ?? 1).toDouble();
    _totalDuration = (prefs.getInt('totalDuration') ?? 60 * 30).toDouble();
    _remainingTime = Duration(seconds: _totalDuration.toInt());
    _isAutoMode ? _startAutoTap() : _stopAutoTap();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _remainingTime = Duration(seconds: _totalDuration.toInt());

    _bgmPlayer.setLoopMode(LoopMode.one);

    _bgmPlayer.playerStateStream.listen((state) {
      if (state.playing && state.processingState == ProcessingState.completed) {
        _bgmPlayer.seek(Duration.zero);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pauseBgm();
    } else if (state == AppLifecycleState.resumed && _isBgmPlaying) {
      _resumeBgm();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    _bgmPlayer.dispose();
    _animationController?.dispose();
    _stopAutoTap();
    super.dispose();
  }

  void _playSound() async {
    try {
      await _audioPlayer.setAsset(_soundOptions[_selectedSoundIndex]);
      await _audioPlayer.play();
      setState(() {
        _meritCount++;
      });
      _animationController?.forward(from: 0.0);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final nowKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await prefs.setInt(nowKey, _meritCount);
      _addMeritText();
    } catch (e) {
      print("The sound effect failed to play: $e");
    }
  }

  void _addMeritText() {
    final RenderBox? renderBox =
        _fishKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      setState(() {
        _meritTexts.add(
          const MeritText(
            text: 'Merit virtue +1',
            position: Offset(50, 50),
          ),
        );
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && _meritTexts.isNotEmpty) {
          setState(() {
            _meritTexts.removeAt(0);
          });
        }
      });
    }
  }

  void _startAutoTap() {
    _stopAutoTap();
    setState(() {
      _isAutoMode = true;
      _elapsedTime = Duration.zero;
      _remainingTime = Duration(seconds: _totalDuration.toInt());
    });

    final startTime = DateTime.now();
    _autoTimer = Timer.periodic(
        Duration(milliseconds: (_interval * 1000).round()), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final currentTime = DateTime.now();
      final elapsed = currentTime.difference(startTime);

      if (elapsed.inSeconds >= _totalDuration) {
        _stopAutoTap();
        return;
      }

      setState(() {
        _elapsedTime = elapsed;
        _remainingTime =
            Duration(seconds: _totalDuration.toInt()) - _elapsedTime;
      });

      _playSound();
    });
  }

  void _stopAutoTap() {
    _autoTimer?.cancel();
    setState(() {
      _isAutoMode = false;
    });
  }

  Future<void> _playBgm() async {
    if (_selectedBgmIndex == 0) {
      await _bgmPlayer.stop();
      setState(() {
        _isBgmPlaying = false;
      });
      return;
    }

    try {
      setState(() {
        _isBgmPlaying = true;
      });
      await _bgmPlayer.setAsset(_bgmOptions[_selectedBgmIndex]);
      await _bgmPlayer.play();

    } catch (e) {
      print("The background music restoration failed: $e");
      setState(() {
        _isBgmPlaying = false;
      });
    }
  }

  Future<void> _pauseBgm() async {
    if (_isBgmPlaying) {
      await _bgmPlayer.pause();
      setState(() {
        _isBgmPlaying = false;
      });
    }
  }

  Future<void> _resumeBgm() async {
    if (!_isBgmPlaying && _selectedBgmIndex > 0) {
      try {
        setState(() {
          _isBgmPlaying = true;
        });
        await _bgmPlayer.play();

      } catch (e) {
        setState(() {
          _isBgmPlaying = false;
        });
        print("The background music restoration failed: $e");
      }
    }
  }

  Future<void> _stopBgm() async {
    await _bgmPlayer.stop();
    setState(() {
      _isBgmPlaying = false;
    });
  }

  void _onBgmChanged(int? value) async {
    if (value == null) return;

    setState(() {
      _selectedBgmIndex = value;
    });

    await _stopBgm();

    if (value > 0) {
      await _playBgm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: <Widget>[
          Image.asset(
            'assets/icon0.png',
            fit: BoxFit.cover,
          ).marginOnly(left: 20).gestures(onTap: () {
            Get.toNamed('/FishSettingPage')?.then((_) {
              getData();
            });
          })
        ].toRow(),
        leadingWidth: 60,
        automaticallyImplyLeading: false,
        actions: [
          Image.asset(
            'assets/icon1.png',
            fit: BoxFit.cover,
          ).marginOnly(right: 20).gestures(onTap: () {
            Get.toNamed('/AppSettingPage')?.then((_) {
              getData();
            });
          })
        ],
      ),
      body: SafeArea(
          child: <Widget>[
        <Widget>[
          GestureDetector(
            onTap: _isAutoMode ? null : _playSound,
            child: ScaleTransition(
              scale: _animationController!,
              child: Image.asset(
                key: _fishKey,
                'assets/big$_selectedBigImgIndex.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ..._meritTexts,
        ].toStack(),
        const SizedBox(
          height: 120,
        ),
        Text(
          'Today: $_meritCount times',
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 60,
        ),
        Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: <Widget>[
            Image.asset(
              'assets/icon2.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DropdownButton<int>(
                value: _selectedBgmIndex,
                items: List.generate(_bgmOptions.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                        _bgmOptions[index].split('/').last.replaceAll('.mp3', '').replaceAll('bg', 'Background music'),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
                dropdownColor: Colors.black.withAlpha(100),
                onChanged: _onBgmChanged,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/icon${_isBgmPlaying ? 4 : 3}.png',
              fit: BoxFit.cover,
            ).gestures(onTap: () {
              if (_isBgmPlaying) {
                _pauseBgm();
              } else {
                _resumeBgm();
              }
            }),
          ].toRow(),
        ).decorated(
            color: const Color(0xff313236),
            borderRadius: BorderRadius.circular(40))
      ]
              .toColumn(mainAxisAlignment: MainAxisAlignment.end)
              .marginSymmetric(horizontal: 15)),
    );
  }
}

class MeritText extends StatefulWidget {
  final String text;
  final Offset position;

  const MeritText({
    Key? key,
    required this.text,
    required this.position,
  }) : super(key: key);

  @override
  _MeritTextState createState() => _MeritTextState();
}

class _MeritTextState extends State<MeritText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.position,
      end: widget.position + const Offset(0, -50),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          right: _offsetAnimation.value.dx,
          top: _offsetAnimation.value.dy,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
