//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_resource;

/**
 * The use of this interface is similar to that of ImageBundle. Declare
 * no-argument functions that return subclasses of {@link ResourcePrototype},
 * which are annotated with {@link ClientBundle.Source} annotations specifying
 * the classpath location of the resource to include in the output. At runtime,
 * the functions will return an object that can be used to access the data in
 * the original resource.
 */
abstract class ClientBundle {
  Source source;
}

/**
 * Specifies the classpath location of the resource or resources associated
 * with the {@link ResourcePrototype}.
 */
abstract class Source {
  List<String> value();
}
