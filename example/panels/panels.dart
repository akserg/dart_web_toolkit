library panels_example;

import 'dart:html';

import 'package:dart_web_toolkit/ui.dart';

void main() {
  querySelector("#loading").remove();
  //
  RootLayoutPanel root = RootLayoutPanel.get(); 
  //
  HeaderPanel pnl = new HeaderPanel()
    ..setHeaderWidget( new Label( 'Header' ))
    ..setContentWidget( new TextBox() )
    ..setFooterWidget( new Label( 'Footer' ));
  root.add( pnl );
}
