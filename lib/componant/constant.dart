import 'package:supabase_flutter/supabase_flutter.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

var id;
var supabaseUrl = 'https://wqoxusuirojmgvnzmhun.supabase.co';
var supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indxb3h1c3Vpcm9qbWd2bnptaHVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg0MDg5NDUsImV4cCI6MjA2Mzk4NDk0NX0.eGRhLdQuAYlRuO_JR3h8tA4LuGHlvuZ-P64tY4st0Ug';
final supabase = Supabase.instance.client;

