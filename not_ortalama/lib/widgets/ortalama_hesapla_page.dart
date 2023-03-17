// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:not_ortalama/constants/app_constants.dart';
import 'package:not_ortalama/helper/data_helper.dart';
import 'package:not_ortalama/model/ders.dart';
import 'package:not_ortalama/widgets/ders_listesi.dart';
import 'package:not_ortalama/widgets/harf_dropdown_widget.dart';
import 'package:not_ortalama/widgets/kredi_dropdown_widget.dart';
import 'package:not_ortalama/widgets/ortalama_goster.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaStatePage();
}

class _OrtalamaHesaplaStatePage extends State<OrtalamaHesaplaPage> {
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              Sabitler.baslikText,
              style: Sabitler.baslikStyle,
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(ortalama: DataHelper.ortalamaHesapla(), dersSayisi: DataHelper.tumEklenenDersler.length),
              ),
            ],
          ),
          Expanded(
            child: DersListesi(
              onElemanCikarildi: (index){
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {
                  
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: Sabitler.yatayPaddiing8,
              child: _buildFormField(),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: Sabitler.yatayPaddiing8,
                    child: HarfDropdownWidget(
                      onHarfSecildi: (harf){
                        secilenHarfDegeri = harf;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: Sabitler.yatayPaddiing8,
                    child: KrediDropdownWidget(
                      onKrediSecildi: (kredi){
                        secilenKrediDegeri = kredi;
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _dersEkleveOrtalamaHesapla,
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                  color: Sabitler.anaRenk,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            )
          ],
        ));
  }

  _buildFormField() {
    return TextFormField(
        onSaved: (deger) {
          setState(() {
            girilenDersAdi = deger!;
          });
        },
        validator: (s) {
          if (s!.length <= 0) {
            return "Ders Adını Giriniz";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            hintText: "Matematik",
            border: OutlineInputBorder(
                borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
            filled: true,
            fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3)));
  }

  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers =
          Ders(ad: girilenDersAdi, harfDegeri: secilenHarfDegeri, krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {
        
      });
    }
  }
}
