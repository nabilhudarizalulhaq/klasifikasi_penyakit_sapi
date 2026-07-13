import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class CowDataScreen extends StatefulWidget {
  const CowDataScreen({super.key, required this.cows});
  final List<Cow> cows;
  @override State<CowDataScreen> createState() => _CowDataScreenState();
}

class _CowDataScreenState extends State<CowDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  String _gender = 'Betina';
  String _type = 'Sapi Perah';
  bool _showForm = false;

  @override void dispose(){ _name.dispose(); _age.dispose(); super.dispose(); }

  void _save(){
    if(!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      widget.cows.add(Cow(id: DateTime.now().millisecondsSinceEpoch, name: _name.text.trim(), age: int.parse(_age.text), gender: _gender, type: _type));
      _name.clear(); _age.clear(); _gender='Betina'; _type='Sapi Perah'; _showForm=false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ScreenHeader(title: 'Data Sapi Saya', actions: [IconButton(onPressed: ()=>setState(()=>_showForm=!_showForm), icon: Icon(_showForm?Icons.close:Icons.add_circle_outline))]),
    body: ListView(padding: const EdgeInsets.all(24), children: [
      if(_showForm) ...[
        AppCard(child: Form(key:_formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          const Text('Tambah Data Sapi', style: TextStyle(fontSize:18,fontWeight:FontWeight.w700)), const SizedBox(height:18),
          TextFormField(controller:_name, decoration: const InputDecoration(labelText:'Nama Sapi', hintText:'Contoh: Bella'), validator:(v)=>v==null||v.trim().isEmpty?'Nama sapi wajib diisi':null), const SizedBox(height:14),
          TextFormField(controller:_age, keyboardType:TextInputType.number, decoration: const InputDecoration(labelText:'Umur (bulan)', hintText:'Contoh: 24'), validator:(v)=>int.tryParse(v??'')==null?'Masukkan umur yang valid':null), const SizedBox(height:14),
          DropdownButtonFormField<String>(initialValue:_gender, decoration:const InputDecoration(labelText:'Jenis Kelamin'), items:['Betina','Jantan'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(), onChanged:(v)=>setState(()=>_gender=v!)), const SizedBox(height:14),
          DropdownButtonFormField<String>(initialValue:_type, decoration:const InputDecoration(labelText:'Jenis Sapi'), items:['Sapi Perah','Sapi Potong','Sapi Lokal'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(), onChanged:(v)=>setState(()=>_type=v!)), const SizedBox(height:20),
          PrimaryButton(label:'Simpan Data', icon:Icons.save_outlined, onPressed:_save),
        ]))), const SizedBox(height:18),
      ],
      if(widget.cows.isEmpty) AppCard(child: Column(children:[Container(width:72,height:72,decoration:const BoxDecoration(color:AppColors.emeraldLight,shape:BoxShape.circle),child:const Icon(Icons.storage_outlined,size:34,color:AppColors.emerald)),const SizedBox(height:16),const Text('Belum Ada Data Sapi',style:TextStyle(fontSize:17,fontWeight:FontWeight.w700)),const SizedBox(height:6),const Text('Tambahkan data sapi untuk mempermudah pencatatan diagnosis.',textAlign:TextAlign.center,style:TextStyle(color:AppColors.slate500)),const SizedBox(height:18),PrimaryButton(label:'Tambah Data Sapi',icon:Icons.add,onPressed:()=>setState(()=>_showForm=true))]))
      else ...widget.cows.map((cow)=>Padding(padding:const EdgeInsets.only(bottom:14),child:AppCard(child:Row(children:[
        Container(width:52,height:52,decoration:const BoxDecoration(color:AppColors.emeraldLight,shape:BoxShape.circle),child:const Icon(Icons.pets,color:AppColors.emerald)),const SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(cow.name,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w700)),const SizedBox(height:4),Text('${cow.type} • ${cow.gender} • ${cow.age} bulan',style:const TextStyle(fontSize:13,color:AppColors.slate500))])),
        IconButton(onPressed:()=>setState(()=>widget.cows.removeWhere((e)=>e.id==cow.id)),icon:const Icon(Icons.delete_outline,color:Colors.redAccent))
      ]))))
    ]),
    floatingActionButton: widget.cows.isNotEmpty ? FloatingActionButton(onPressed:()=>setState(()=>_showForm=true),backgroundColor:AppColors.emerald,foregroundColor:Colors.white,child:const Icon(Icons.add)) : null,
  );
}
