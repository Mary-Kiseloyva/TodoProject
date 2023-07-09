class TodoModel {
  final int? id;
  final String text;
  final DateTime? deadLine;
  final bool done;

  TodoModel(
      { this.id,
      required this.text,
      required this.deadLine,
      required this.done});

  TodoModel copyWith({
    int? id,
    String? text,
    DateTime? deadLine,
    bool? done,
  }) {
    return TodoModel(
        id: id ?? this.id,
        text: text ?? this.text,
        deadLine: deadLine ?? this.deadLine,
        done: done ?? this.done);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          deadLine == other.deadLine &&
          done == other.done;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ deadLine.hashCode ^ done.hashCode;
}
