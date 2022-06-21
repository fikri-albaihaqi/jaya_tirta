class Validator {
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Masukan email yang valid';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (password.length < 6) {
      return 'Panjang password minimal 6 karakter';
    }

    return null;
  }

  static String? validateNama({required String? nama}) {
    RegExp regExp = RegExp(r'^[a-zA-Z.-\s]+$');
    if (nama == null) {
      return null;
    }
    if (nama.isEmpty) {
      return 'Nama tidak boleh kosong';
    } else if (!regExp.hasMatch(nama)) {
      return 'Nama hanya boleh diisi dengan huruf';
    } else if (nama.length < 3) {
      return 'Panjang nama minimal 2 huruf';
    }

    return null;
  }

  static String? validateNamaProduk({required String? namaProduk}) {
    RegExp regExp = RegExp(r'^[a-zA-Z.-]+$');
    if (namaProduk == null) {
      return null;
    }
    if (namaProduk.isEmpty) {
      return 'Nama produk tidak boleh kosong';
    } else if (!regExp.hasMatch(namaProduk)) {
      return 'Nama produk hanya boleh diisi dengan huruf';
    } else if (namaProduk.length < 3) {
      return 'Panjang nama minimal 2 huruf';
    }

    return null;
  }

  static String? validateStok({required String? stok}) {
    if (stok == null) {
      return null;
    }
    if (stok.isEmpty) {
      return 'Stok tidak boleh kosong';
    }

    return null;
  }

  static String? validateHarga({required String? harga}) {
    RegExp regExp = RegExp(r'^[0-9]+$');
    if (harga == null) {
      return null;
    }
    if (harga.isEmpty) {
      return 'Harga tidak boleh kosong';
    } else if (!regExp.hasMatch(harga)) {
      return 'Harga hanya boleh diisi nomor';
    } else if (harga.length < 5) {
      return 'Harga minimal 4 digit';
    }

    return null;
  }

  static String? validateKecKelurahan({required String? keckelurahan}) {
    if (keckelurahan == null) {
      return null;
    }
    if (keckelurahan.isEmpty) {
      return 'Kecamatan/Kelurahan tidak boleh kosong';
    } else if (keckelurahan.length < 3) {
      return 'Panjang kecamatan/kelurahan minimal 2 huruf';
    }

    return null;
  }

  static String? validateAlamat({required String? alamat}) {
    if (alamat == null) {
      return null;
    }
    if (alamat.isEmpty) {
      return 'Alamat tidak boleh kosong';
    } else if (alamat.length < 6) {
      return 'Panjang alamat minimal 5 huruf';
    }

    return null;
  }

  static String? validateNoTelp({required String? noTelp}) {
    RegExp regExp = RegExp(r'^[0-9]+$');
    if (noTelp == null) {
      return null;
    }
    if (noTelp.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    } else if (!regExp.hasMatch(noTelp)) {
      return 'Nomor telepon hanya boleh diisi nomor';
    } else if (noTelp.length < 11) {
      return 'Panjang nomor telepon minimal 10 digit';
    }

    return null;
  }

  static String? validateNoTelpDataPenjualan({required String? noTelp}) {
    RegExp regExp = RegExp(r'^[0-9-]+$');
    if (noTelp == null) {
      return null;
    }
    if (noTelp.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    } else if (!regExp.hasMatch(noTelp)) {
      return 'Nomor telepon hanya boleh diisi nomor';
    }

    return null;
  }
}
