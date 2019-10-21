import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

import './preview.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pick Image Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Pick Image Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with LoadingDelegate {
  String currentSelected = "";

  @override
  Widget buildBigImageLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return Center(
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CupertinoActivityIndicator(
          radius: 25.0,
        ),
      ),
    );
  }

  @override
  Widget buildPreviewLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return Center(
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CupertinoActivityIndicator(
          radius: 25.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.image),
            onPressed: _testPhotoListParams,
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              IconTextButton(
                  icon: Icons.photo,
                  text: "photo",
                  onTap: () => _pickAsset(PickType.onlyImage)),
              IconTextButton(
                  icon: Icons.videocam,
                  text: "video",
                  onTap: () => _pickAsset(PickType.onlyVideo)),
              IconTextButton(
                  icon: Icons.album,
                  text: "all",
                  onTap: () => _pickAsset(PickType.all)),
              Text(
                '$currentSelected',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _pickAsset(PickType.all),
        tooltip: 'pickImage',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _testPhotoListParams() async {
    var assetPathList = await PhotoManager.getImageAsset();
    _pickAsset(PickType.all, pathList: assetPathList);
  }

  void _pickAsset(PickType type, {List<AssetPathEntity> pathList}) async {
    List<AssetEntity> imgList = await PhotoPicker.pickAsset(
      // BuildContext required
      context: context,

      /// The following are optional parameters.
      themeColor: Colors.black,
      // the title color and bottom color
      textColor: Colors.white,
      // the check box disable color
      itemRadio: 1,
      // the content item radio
      maxSelected: 2,
      disableColor: Color(0xFFFFFFFF).withOpacity(0.5),
      splashColor: Color(0xFF0080FF),
      padding: 0,
      // max picker image count
      // provider: I18nProvider.english,
      provider: I18nProvider.chinese,
      // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 4,
      // item row count

      thumbSize: 150,
      // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

      pickType: type,
      checkBoxBuilderDelegate: IconBoxBuilderDelegate(
          active: Icon(Icons.check_circle, color: Colors.blue,),
          unselected: Icon(Icons.check_circle_outline,color: Colors.white,)),

      photoPathList: pathList,
    );

    if (imgList == null) {
      currentSelected = "not select item";
    } else {
      List<String> r = [];
      for (var e in imgList) {
        var file = await e.file;
        r.add(file.absolute.path);
      }
      currentSelected = r.join("\n\n");

      List<AssetEntity> preview = [];
      preview.addAll(imgList);
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => PreviewPage(list: preview)));
    }
    setState(() {});
  }
}

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  const IconTextButton({Key key, this.icon, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: ListTile(
          leading: Icon(icon ?? Icons.device_unknown),
          title: Text(text ?? ""),
        ),
      ),
    );
  }
}
