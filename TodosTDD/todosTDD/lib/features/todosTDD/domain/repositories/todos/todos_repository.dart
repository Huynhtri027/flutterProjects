// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';


abstract class TodosRepository {
  Future<void> addNewTodo(TodoEntity todo);

  Future<void> deleteTodo(TodoEntity todo);

  Stream<List<TodoEntity>> todos();

  Future<void> updateTodo(TodoEntity todo);
}
