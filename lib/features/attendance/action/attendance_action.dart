import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sis/features/attendance/model/attendance_model.dart';

part 'attendance_action.freezed.dart';

@freezed
sealed class AttendanceAction with _$AttendanceAction {
  const factory AttendanceAction.checkedIn(AttendanceModel data) = CheckedIn;
  const factory AttendanceAction.checkedOut(AttendanceModel data) = CheckedOut;
  const factory AttendanceAction.lateCheckInRequired() = LateCheckInRequired;
  const factory AttendanceAction.alreadyCheckedIn() = AlreadyCheckedIn;
  const factory AttendanceAction.markedAbsent() = MarkedAbsent;
  const factory AttendanceAction.invalidIP() = InvalidIP;
}
