// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookCMAdapter extends TypeAdapter<BookCM> {
  @override
  final int typeId = 1;

  @override
  BookCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookCM(
      status: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BookCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
