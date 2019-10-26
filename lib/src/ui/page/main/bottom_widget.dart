part of '../photo_main_page.dart';

class _BottomWidget extends StatefulWidget {
  final ValueChanged<AssetPathEntity> onGalleryChange;

  final Options options;

  final I18nProvider provider;

  final SelectedProvider selectedProvider;

  final String galleryName;

  final GalleryListProvider galleryListProvider;
  final VoidCallback onTapPreview;
  final VoidCallback onTapCommit;

  const _BottomWidget({
    Key key,
    this.onGalleryChange,
    this.onTapCommit,
    this.options,
    this.provider,
    this.selectedProvider,
    this.galleryName = "",
    this.galleryListProvider,
    this.onTapPreview,
  }) : super(key: key);

  @override
  __BottomWidgetState createState() => __BottomWidgetState();
}

class __BottomWidgetState extends State<_BottomWidget> {
  Options get options => widget.options;

  I18nProvider get i18nProvider => widget.provider;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 16.0);
    return Container(
      color: options.themeColor,
      child: SafeArea(
        bottom: true,
        top: false,
        child: Container(
          height: 52.0,
          child: Row(
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: widget.onTapPreview,
                textColor: options.textColor,
                splashColor: Colors.transparent,
                disabledTextColor: options.disableColor,
                child: Container(
                  height: 38.0,
                  alignment: Alignment.center,
                  child: Text(
                    i18nProvider.getPreviewText(
                        options, widget.selectedProvider),
                    style: textStyle,
                  ),
                ),
              ),
//              Expanded(
//                child: FlatButton(
//                  onPressed: _showGallerySelectDialog,
//                  splashColor: Colors.transparent,
//                  child: Container(
//                    alignment: Alignment.center,
//                    height: 44.0,
//                    padding: textPadding,
//                    child: Text(
//                      widget.galleryName,
//                      style: textStyle.copyWith(color: options.textColor),
//                    ),
//                  ),
//                ),
//              ),
              Spacer(),
              FlatButton(
                onPressed: widget.selectedProvider.selectedCount <= 0
                    ? null
                    : widget.onTapCommit,
                disabledColor: Color(0xFFC8C8C8),
                disabledTextColor: options.textColor,
                padding: EdgeInsets.all(0),
                textColor: options.textColor,
                splashColor: Colors.transparent,
                color: options.splashColor,
                child: Container(
                  height: 38.0,
                  constraints: BoxConstraints(minWidth: 100),
                  alignment: Alignment.center,
                  child: Text(
                    i18nProvider.getSureText(
                        options, widget.selectedProvider.selectedCount),
                    style: textStyle,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showGallerySelectDialog() async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (ctx) => ChangeGalleryDialog(
        galleryList: widget.galleryListProvider.galleryPathList,
        i18n: i18nProvider,
        options: options,
      ),
    );

    if (result != null) widget.onGalleryChange?.call(result);
  }
}
