import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusdatin_end/pages/page_login.dart';

void main() {
  group('Halaman Login', () {
    testWidgets('Field Email menampilkan error jika email kosong', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Temukan tombol login dan tekan
      final tombolLoginFinder = find.text('Masuk');
      await tester.tap(tombolLoginFinder);

      // Tunggu animasi
      await tester.pump();

      // Periksa apakah pesan error muncul untuk email kosong
      expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    });

    testWidgets('Field Email menampilkan error jika format email tidak valid', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Masukkan email yang tidak valid
      await tester.enterText(find.byType(TextFormField).first, 'email-tidak-valid');
      
      // Temukan tombol login dan tekan
      final tombolLoginFinder = find.text('Masuk');
      await tester.tap(tombolLoginFinder);

      // Tunggu animasi
      await tester.pump();

      // Periksa apakah pesan error muncul untuk email tidak valid
      expect(find.text('Masukkan email yang valid'), findsOneWidget);
    });

    testWidgets('Field Password menampilkan error jika password kosong', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Masukkan email yang valid
      await tester.enterText(find.byType(TextFormField).first, 'admin@mail.com');

      // Temukan tombol login dan tekan
      final tombolLoginFinder = find.text('Masuk');
      await tester.tap(tombolLoginFinder);

      // Tunggu animasi
      await tester.pump();

      // Periksa apakah pesan error muncul untuk password kosong
      expect(find.text('Password tidak boleh kosong'), findsOneWidget);
    });

    testWidgets('Field Password menampilkan error jika password kurang dari 6 karakter', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Masukkan email yang valid dan password kurang dari 6 karakter
      await tester.enterText(find.byType(TextFormField).first, 'admin@mail.com');
      await tester.enterText(find.byType(TextFormField).last, 'admin');

      // Temukan tombol login dan tekan
      final tombolLoginFinder = find.text('Masuk');
      await tester.tap(tombolLoginFinder);

      // Tunggu animasi
      await tester.pump();

      // Periksa apakah pesan error muncul untuk password kurang dari 6 karakter
      expect(find.text('Password minimal 6 karakter'), findsOneWidget);
    });

    testWidgets('Form valid jika email dan password benar', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Masukkan email dan password yang valid
      await tester.enterText(find.byType(TextFormField).first, 'admin@mail.com');
      await tester.enterText(find.byType(TextFormField).last, 'admin123');

      // Temukan tombol login dan tekan
      final tombolLoginFinder = find.text('Masuk');
      await tester.tap(tombolLoginFinder);

      // Tunggu animasi
      await tester.pump();

      // Periksa apakah tidak ada pesan error yang muncul
      expect(find.text('Email tidak boleh kosong'), findsNothing);
      expect(find.text('Masukkan email yang valid'), findsNothing);
      expect(find.text('Password tidak boleh kosong'), findsNothing);
      expect(find.text('Password minimal 6 karakter'), findsNothing);
    });
  });
}
