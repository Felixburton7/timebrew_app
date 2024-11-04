// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerSettingAdapter extends TypeAdapter<TimerSetting> {
  @override
  final int typeId = 0;

  @override
  TimerSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerSetting(
      durationInSeconds: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimerSetting obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.durationInSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
