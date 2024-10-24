import 'package:equatable/equatable.dart';
import 'package:hse_app/product.dart';

abstract class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {
  final Product product;

  const ScanSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ScanFailure extends ScanState {
  final String error;

  const ScanFailure(this.error);

  @override
  List<Object> get props => [error];
}
