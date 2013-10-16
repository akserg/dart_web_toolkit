//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library grid_example;

import 'package:dart_web_toolkit/ui.dart' as ui;

void main() {
  // Create a static tree and a container to hold it
  ui.Tree tree = createStaticTree();
  tree.setAnimationEnabled(true);

  ui.RootPanel.get().add(tree);
}

/**
 * Create a static tree with some data in it.
*
 * @return the new tree
 */
ui.Tree createStaticTree() {
  // Create the tree
  List<String> composers = ["Beethoven", "Brahms", "Mozart"];
  String concertosLabel = "Concertos";
  String quartetsLabel = "Quartets";
  String sonatasLabel = "Sonatas";
  String symphoniesLabel = "Symphonies";
  ui.Tree staticTree = new ui.Tree();

  // Add some of Beethoven's music
  ui.TreeItem beethovenItem = staticTree.addTextItem(composers[0]);
  addMusicSection(beethovenItem, concertosLabel, ["No. 1 - C", "No. 2 - B-Flat Major", "No. 3 - C Minor", "No. 4 - G Major", "No. 5 - E-Flat Major"]);
  addMusicSection(beethovenItem, quartetsLabel, ["Six String Quartets", "Three String Quartets", "Grosse Fugue for String Quartets"]);
  addMusicSection(beethovenItem, sonatasLabel, ["Sonata in A Minor", "Sonata in F Major"]);
  addMusicSection(beethovenItem, symphoniesLabel, ["No. 2 - D Major", "No. 2 - D Major", "No. 3 - E-Flat Major", "No. 4 - B-Flat Major", "No. 5 - C Minor", "No. 6 - F Major", "No. 7 - A Major", "No. 8 - F Major", "No. 9 - D Minor"]);

  // Add some of Brahms's music
  ui.TreeItem brahmsItem = staticTree.addTextItem(composers[1]);
  addMusicSection(brahmsItem, concertosLabel, ["Violin Concerto", "Double Concerto - A Minor", "Piano Concerto No. 1 - D Minor", "Piano Concerto No. 2 - B-Flat Major"]);
  addMusicSection(brahmsItem, quartetsLabel, ["Piano Quartet No. 1 - G Minor", "Piano Quartet No. 2 - A Major", "Piano Quartet No. 3 - C Minor", "String Quartet No. 3 - B-Flat Minor"]);
  addMusicSection(brahmsItem, sonatasLabel, ["Two Sonatas for Clarinet - F Minor", "Two Sonatas for Clarinet - E-Flat Major"]);
  addMusicSection(brahmsItem, symphoniesLabel, ["No. 1 - C Minor", "No. 2 - D Minor", "No. 3 - F Major", "No. 4 - E Minor"]);

  // Add some of Mozart's music
  ui.TreeItem mozartItem = staticTree.addTextItem(composers[2]);
  addMusicSection(mozartItem, concertosLabel, ["Piano Concerto No. 12", "Piano Concerto No. 17", "Clarinet Concerto", "Violin Concerto No. 5", "Violin Concerto No. 4"]);

  // Return the tree
  return staticTree;
}

/**
 * Add a new section of music created by a specific composer.
*
 * @param parent the parent {@link TreeItem} where the section will be added
 * @param label the label of the new section of music
 * @param composerWorks an array of works created by the composer
 */
void addMusicSection(ui.TreeItem parent, String label, List<String> composerWorks) {
  ui.TreeItem section = parent.addTextItem(label);
  for (String work in composerWorks) {
    section.addTextItem(work);
  }
}