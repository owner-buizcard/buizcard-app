part of 'ai_bloc.dart';

sealed class AiEvent extends Equatable {
  const AiEvent();

  @override
  List<Object> get props => [];
}

class ExtractContactEvent extends AiEvent {
  final String content;
  const ExtractContactEvent({
    required this.content
  });
}