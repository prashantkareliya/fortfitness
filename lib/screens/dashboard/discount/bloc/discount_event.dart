part of 'discount_bloc.dart';

@immutable
sealed class DiscountEvent {}

//Get All services event
class GetDiscountEvent extends DiscountEvent {
  GetDiscountEvent();
}

//Discount claim event
class ClaimDiscountEvent extends DiscountEvent {
  final DiscountClaimRequest discountClaimRequest;
  ClaimDiscountEvent(this.discountClaimRequest);
}
