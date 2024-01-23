import 'dart:convert';

import 'package:bizcard_app/constants/credentials.dart';
import 'package:bizcard_app/models/contact_info.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  AiBloc() : super(AiInitial()) {
    on<ExtractContactEvent>(_onExtractContactEvent);
  }
_onExtractContactEvent(ExtractContactEvent event, Emitter emit) async {
  emit(Loading());

  try {
    final dio = Dio();

    final response = await dio.post(
      'https://api.openai.com/v1/completions',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Credentials.gptKey}',
        },
      ),
      data: {
        "model": "gpt-3.5-turbo-instruct",
        "prompt": 'Generate a map in the specified format using the given information.\nInformation: ${event.content}\nMap Format: {"name":"", "title":"", "phone":"", "email":"", "location":"", "companyName":""}',
        "max_tokens": 250,
        "temperature": 0,
        "top_p": 1,
      },
    );

    final String content = response.data["choices"][0]["text"];

    try {
      var generatedMap = ContactInfo.fromJson(jsonDecode(content));
      emit(ExtractedContact(contact: generatedMap));
    } catch (e) {
      emit(Failure());
    }
  } catch (error) {
    emit(Failure());
  }
}

}
