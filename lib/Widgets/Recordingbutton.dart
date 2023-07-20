import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

typedef RecordCallback = void Function(String);

class RecordButton extends StatefulWidget {
  const RecordButton({
    Key? key,
    required this.recordingFinishedCallback,
  }) : super(key: key);

  final RecordCallback recordingFinishedCallback;

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool _isRecording = false;
  final _audioRecorder = Record();
  Timer? _timer;
  int _secondsElapsed = 0;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _secondsElapsed = 0;
  }

  void _showRecordingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _isRecording ? 120 : 60,
                  width: _isRecording ? 120 : 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.withOpacity(0.3),
                  ),
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: _isRecording ? 60 : 40,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Recording...',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _stopTimer();
                        _stop();
                      },
                      child: Text('Send'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _stopTimer();
                        _stop();
// Close the dialog
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(
          path: '/data/user/0/com.teen.jungle/cache/temp.mp3',
          encoder: AudioEncoder.aacLc,
        );

        bool isRecording = await _audioRecorder.isRecording();
        if (isRecording) {
          setState(() {
            _isRecording = true;
          });
          _startTimer();
          _showRecordingDialog();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();
    widget.recordingFinishedCallback(path!);
    setState(() => _isRecording = false);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final Color? color;
    if (_isRecording) {
      icon = Icons.stop;
      color = Colors.red.withOpacity(0.3);
    } else {
      color = Colors.black;
      icon = Icons.mic;
    }
    return GestureDetector(
      onTap: () {
        _isRecording ? _stop() : _start();
      },
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
