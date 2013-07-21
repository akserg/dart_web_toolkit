//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library grid_example;

import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/i18n.dart' as i18n;

void main() {
  ui.Grid grid = new ui.Grid(1, 2);
  grid.setCellPadding(2);
  grid.getRowFormatter().setVerticalAlign(0, i18n.HasVerticalAlignment.ALIGN_TOP);
  grid.setHtml(0, 0, "<b>Cell 0x0</b>");
  grid.setWidget(0, 1, new ui.Label("Cell 0x1"));
  ui.RootPanel.get().add(grid);
}