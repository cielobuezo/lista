import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/group.dart';
import 'models/task.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 586994004397638345),
      name: 'Group',
      lastPropertyId: const IdUid(3, 3110047137086222315),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4822138929835461462),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3106064712501613684),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3110047137086222315),
            name: 'color',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'tasks', srcEntity: 'Task', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 6653641660077929981),
      name: 'Task',
      lastPropertyId: const IdUid(4, 4913475954066841383),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 786878669067430661),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5491558786345425143),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7578808805812497058),
            name: 'completed',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4913475954066841383),
            name: 'groupId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 6057328437318098031),
            relationTarget: 'Group')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 6653641660077929981),
      lastIndexId: const IdUid(1, 6057328437318098031),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Group: EntityDefinition<Group>(
        model: _entities[0],
        toOneRelations: (Group object) => [],
        toManyRelations: (Group object) => {
              RelInfo<Task>.toOneBacklink(
                      4, object.id, (Task srcObject) => srcObject.group):
                  object.tasks
            },
        getId: (Group object) => object.id,
        setId: (Group object, int id) {
          object.id = id;
        },
        objectToFB: (Group object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addInt64(2, object.color);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Group(
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              color: const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          InternalToManyAccess.setRelInfo(
              object.tasks,
              store,
              RelInfo<Task>.toOneBacklink(
                  4, object.id, (Task srcObject) => srcObject.group),
              store.box<Group>());
          return object;
        }),
    Task: EntityDefinition<Task>(
        model: _entities[1],
        toOneRelations: (Task object) => [object.group],
        toManyRelations: (Task object) => {},
        getId: (Task object) => object.id,
        setId: (Task object, int id) {
          object.id = id;
        },
        objectToFB: (Task object, fb.Builder fbb) {
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descriptionOffset);
          fbb.addBool(2, object.completed);
          fbb.addInt64(3, object.group.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Task(
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..completed =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false);
          object.group.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.group.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Group] entity fields to define ObjectBox queries.
// ignore: camel_case_types
class Group_ {
  /// see [Group.id]
  static final id = QueryIntegerProperty<Group>(_entities[0].properties[0]);

  /// see [Group.name]
  static final name = QueryStringProperty<Group>(_entities[0].properties[1]);

  /// see [Group.color]
  static final color = QueryIntegerProperty<Group>(_entities[0].properties[2]);
}

/// [Task] entity fields to define ObjectBox queries.
// ignore: camel_case_types
class Task_ {
  /// see [Task.id]
  static final id = QueryIntegerProperty<Task>(_entities[1].properties[0]);

  /// see [Task.description]
  static final description =
      QueryStringProperty<Task>(_entities[1].properties[1]);

  /// see [Task.completed]
  static final completed =
      QueryBooleanProperty<Task>(_entities[1].properties[2]);

  /// see [Task.group]
  static final group =
      QueryRelationToOne<Task, Group>(_entities[1].properties[3]);
}
