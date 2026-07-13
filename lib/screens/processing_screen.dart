import 'dart:async';
import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'result_screen.dart';

class ProcessingScreen extends StatefulWidget{
  const ProcessingScreen({super.key,required this.symptoms,required this.cow,required this.history});
  final List<String> symptoms; final Cow? cow; final List<DiagnosisHistory> history;
  @override State<ProcessingScreen> createState()=>_ProcessingScreenState();
}
class _ProcessingScreenState extends State<ProcessingScreen>{
  Timer? timer;
  @override void initState(){super.initState();timer=Timer(const Duration(seconds:2),(){if(!mounted)return;final result=_diagnose(widget.symptoms);Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>ResultScreen(result:result,cow:widget.cow,history:widget.history)));});}
  DiagnosisResult _diagnose(List<String>s){
    if(s.contains('luka-mulut')&&s.contains('luka-kuku')) return DiagnosisResult(disease:'Penyakit Mulut dan Kuku (PMK)',confidence:92,severity:'Tinggi',recommendations:['Isolasi sapi yang terinfeksi segera','Hubungi dokter hewan untuk penanganan lanjut','Desinfeksi kandang dan peralatan','Berikan pakan yang lembut','Laporkan ke dinas peternakan setempat'],symptoms:s);
    if(s.contains('benjolan-kulit')) return DiagnosisResult(disease:'Lumpy Skin Disease',confidence:88,severity:'Tinggi',recommendations:['Isolasi sapi yang terinfeksi','Hubungi dokter hewan segera','Lakukan vaksinasi sapi lain','Jaga kebersihan kandang','Kontrol serangga di sekitar kandang'],symptoms:s);
    if(s.contains('produksi-susu')||s.contains('ambing-bengkak')) return DiagnosisResult(disease:'Mastitis',confidence:85,severity:'Sedang',recommendations:['Periksa ambing secara menyeluruh','Konsultasi dengan dokter hewan','Jaga kebersihan peralatan perah','Berikan obat sesuai resep','Pisahkan susu sapi terinfeksi'],symptoms:s);
    if(s.contains('sesak-napas')||s.contains('batuk')) return DiagnosisResult(disease:'Infeksi Pernapasan',confidence:81,severity:'Sedang',recommendations:['Pindahkan ke tempat berventilasi baik','Jaga kebersihan kandang','Konsultasi dokter hewan','Berikan obat sesuai resep','Pantau suhu tubuh'],symptoms:s);
    if(s.contains('diare')||s.contains('nafsu-makan')) return DiagnosisResult(disease:'Gangguan Pencernaan',confidence:78,severity:'Rendah',recommendations:['Berikan air minum yang cukup','Kurangi pakan konsentrat','Berikan pakan berserat','Pantau kondisi sapi','Hubungi dokter jika tidak membaik'],symptoms:s);
    return DiagnosisResult(disease:'Pemeriksaan Lebih Lanjut Diperlukan',confidence:65,severity:'Rendah',recommendations:['Gejala belum cukup untuk diagnosis pasti','Hubungi dokter hewan','Pantau perkembangan gejala','Catat gejala tambahan','Jaga kondisi kesehatan sapi'],symptoms:s);
  }
  @override void dispose(){timer?.cancel();super.dispose();}
  @override Widget build(BuildContext context)=>Scaffold(body:Container(width:double.infinity,decoration:const BoxDecoration(gradient:LinearGradient(colors:[Colors.white,AppColors.emeraldLight],begin:Alignment.topCenter,end:Alignment.bottomCenter)),child:const SafeArea(child:Center(child:Padding(padding:EdgeInsets.all(32),child:Column(mainAxisSize:MainAxisSize.min,children:[CircularProgressIndicator(color:AppColors.emerald),SizedBox(height:30),Text('Menganalisis Gejala',style:TextStyle(fontSize:23,fontWeight:FontWeight.w800,color:AppColors.slate800)),SizedBox(height:10),Text('Sistem sedang memproses gejala menggunakan model Decision Tree.',textAlign:TextAlign.center,style:TextStyle(color:AppColors.slate500,height:1.5))]))))));
}
