import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'private_policy_state.dart';

class PrivatePolicyCubit extends Cubit<PrivatePolicyState> {
  PrivatePolicyCubit() : super(PrivatePolicyInitial());
}
