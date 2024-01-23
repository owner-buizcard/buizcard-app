part of 'ai_bloc.dart';

sealed class AiState extends Equatable {
  const AiState();
  
  @override
  List<Object> get props => [];
}

final class AiInitial extends AiState {}

class Loading extends AiState {}

class ExtractedContact extends AiState {
  final ContactInfo contact;
  const ExtractedContact({required this.contact});
}

class Failure extends AiState {}
