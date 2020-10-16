// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';

abstract class TodosRepository {
  Future<Either<Failure, void>> addNewTodo(TodoEntity todo);

  Future<Either<Failure, void>> deleteTodo(TodoEntity todo);

  Future<Either<Failure, Stream<List<TodoEntity>>>> todos();

  Future<Either<Failure, void>> updateTodo(TodoEntity todo);
}
