part of 'discount_bloc.dart';

@immutable
sealed class DiscountState {}

final class DiscountInitial extends DiscountState {}

//Get all Discounts states
class DiscountLoading extends DiscountState {
  final bool isBusy;

  DiscountLoading(this.isBusy);
}

class DiscountLoaded extends DiscountState {
  DiscountResponse discountResponse;

  DiscountLoaded({required this.discountResponse});
}

class DiscountFailure extends DiscountState {
  final String error;

  DiscountFailure(this.error);
}

//Claim discount states
class ClaimDiscountLoading extends DiscountState {
  final bool isBusy;
  ClaimDiscountLoading(this.isBusy);
}

class ClaimDiscountLoaded extends DiscountState {
  DiscountClaimResponse discountClaimResponse;
  ClaimDiscountLoaded({required this.discountClaimResponse});
}

class ClaimDiscountFailure extends DiscountState {
  final String error;
  ClaimDiscountFailure(this.error);
}


//Get Claim discount detail
class GetClaimDiscountLoading extends DiscountState {
  final bool isBusy;
  GetClaimDiscountLoading(this.isBusy);
}

class GetClaimDiscountLoaded extends DiscountState {
  GetDiscountClaimResponse getDiscountClaimResponse;
  GetClaimDiscountLoaded({required this.getDiscountClaimResponse});
}

class GetClaimDiscountFailure extends DiscountState {
  final String error;
  GetClaimDiscountFailure(this.error);
}