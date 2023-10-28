import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'dart:math';
import 'package:precycler/screen/screen_changePoint.dart';
import 'dart:io';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>
{
  bool _cameraInitialized = false;
  late CameraController _cameraController;

  @override
  void initState()
  {
    // 화면에 처음 진입할 때 카메라 사용을 준비 하도록 합니다.
    super.initState();
    readyToCamera();
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  void readyToCamera() async
  {
    // 사용할 수 있는 카메라 목록을 OS로부터 받아 옵니다.
    final cameras = await availableCameras();
    if( 0 == cameras.length )
    {
      print( "not found any cameras" );
      return;
    }

    late CameraDescription backCamera;
    for( var camera in cameras )
    {
      // 저 같은 경우에는 전면 카메라를 사용해야 했기 때문에
      // 아래와 같이 코딩하여 카메라를 찾았습니다.
      if( camera.lensDirection == CameraLensDirection.back )
      {
        backCamera = camera;
        break;
      }
    }

    _cameraController =
        CameraController(
          backCamera,
          ResolutionPreset.max, // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다
        );
    _cameraController.initialize()
        .then(
            ( value )
        {
          // 카메라 준비가 끝나면 카메라 미리보기를 보여주기 위해 앱 화면을 다시 그립니다.
          setState( ()=>_cameraInitialized = true );
        } );
  }

  bool _isLoadingChangePointScreen = false;
  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery
        .of(context)
        .size;
    double width = screenSize.width;
    double height = screenSize.height;
    if (_isLoadingChangePointScreen) {
      // ChangePointScreen으로 이동 중일 때 로딩 인디케이터 표시
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      );
    } else {
      // 카메라 초기화되고 UI를 표시할 때 카메라 미리보기 및 기타 UI를 표시
      return _cameraInitialized
          ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: height * 0.05),
              Text(
                '000님의 보유 포인트는 190입니다',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(height: height * 0.08),
              Container(
                height: width * 0.8,
                width: width * 0.8,
                child: _cameraPreview(),
              ),
              Container(height: height * 0.05),
              IconButton(
                onPressed: () async {
                  onSutterPressed(context);
                },
                icon: Icon(Icons.camera_alt),
              ),
            ],
          )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      );
    }
  }
  Widget _cameraPreview() {
    if (_cameraInitialized) {
      return AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Transform.scale(
            scale: _cameraController.value.aspectRatio,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1 / _cameraController.value.aspectRatio,
                child: CameraPreview(_cameraController),
              ),
            ),
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
  void onSutterPressed(BuildContext context) async {
    setState(() {
      _isLoadingChangePointScreen = true;
    });
    _cameraController.setFlashMode(FlashMode.off);

    final XFile image = await _cameraController.takePicture();
    ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
    var cropSize = min(properties.width!,properties.height!);
    int offSetX = (properties.width! - cropSize) ~/2;
    int offSetY = (properties.height! - cropSize) ~/2;
    var imageFile = await FlutterNativeImage.cropImage(image.path, offSetX, offSetY, cropSize, cropSize);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangePointScreen(IncDec: "Dec"),
      ),
    );
    setState(() {
      _isLoadingChangePointScreen = false;
    });
    return;
  }
}