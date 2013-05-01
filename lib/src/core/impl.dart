//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_core;

/**
 * Private implementation class for GWT core. This API is should not be
 * considered public or stable.
 */
class Impl {
  static String getModuleBaseURL() {
//    // Check to see if DevModeRedirectHook has set an alternate value.
//    // The key should match DevModeRedirectHook.js.
//    var key = "__gwtDevModeHook:" + $moduleName + ":moduleBase";
//    var global = $wnd || self;
//    return global[key] || $moduleBase;
    return "src/packages/dart_web_toolkit/";
  }
}