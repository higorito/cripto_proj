import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:hive/hive.dart';

//resumindo, utilizamos o typeadapter para "serializar" e "deserializar" o objeto
//para que o hive consiga salvar no banco de dados
//mas como o nosso objeto é uma classe mais complexa precisamos sobrecrever o typeadapter
//para que ele saiba como salvar e como ler o objeto
class MoedaModelHiveAdapter extends TypeAdapter<MoedaModel> {
  @override
  final typeId = 0;

  @override
  MoedaModel read(BinaryReader reader) {  //metodos do typeadapter(lembra aquela ideia de serializar e deserializar)
    return MoedaModel(
      sigla: reader.readString(),
      nome: reader.readString(),
      cotacao: reader.readDouble(),
      icone: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, MoedaModel obj) {
    writer.writeString(obj.icone);
    writer.writeString(obj.sigla);
    writer.writeString(obj.nome);
    writer.writeDouble(obj.cotacao);
  }

}