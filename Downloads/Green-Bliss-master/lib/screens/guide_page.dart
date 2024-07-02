import 'package:Bliss/screens/guide_details.dart';
import 'package:Bliss/widgets/guide_items.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GuideData {
  final String title;
  final String titleshow;
  final String image;
  final String imageshow;
  final String description;
  final Color background;

  GuideData({
    required this.title,
    required this.image,
    required this.description,
    required this.background,
    required this.imageshow,
    required this.titleshow,
  });
}

// ignore: must_be_immutable
class GuidePage extends StatelessWidget {
  const GuidePage({super.key});
  static List<GuideData> guideDataList = [
    GuideData(
      background: const Color(0xfffdca49),
      title: 'Plásticos & Latas',
      titleshow: '¿Como reciclar materiales plásticos & latas',
      image: 'assets/1.png',
      imageshow: 'assets/item1.jpg',
      description:
          'El plástico ha permeado todos los aspectos de nuestra vida diaria, desde envases de alimentos hasta juguetes y envases de productos de limpieza. Sin embargo, su durabilidad también significa que se acumula en nuestros vertederos y afecta negativamente a nuestro medio ambiente. El reciclaje del plástico es crucial para reducir su impacto y preservar nuestros recursos naturales. Importancia del Reciclaje de Plástico: El plástico es una parte esencial de nuestra vida moderna, pero su desecho inadecuado conlleva consecuencias ambientales significativas. El proceso de fabricación de plástico requiere recursos no renovables y emite gases de efecto invernadero. Además, la acumulación de plástico en los océanos y en los vertederos amenaza la vida marina y contamina nuestros suelos. Reciclar el plástico no solo reduce la cantidad de residuos que ingresan a los vertederos, sino que también disminuye la demanda de materias primas para la producción de plástico nuevo. Esto ayuda a conservar los recursos naturales y reduce la huella de carbono asociada con la fabricación de plástico. Instrucciones para Reciclar Plástico: Clasificación del Plástico: Separa los diferentes tipos de plástico según el código de reciclaje en el envase. Estos códigos, generalmente encontrados en la parte inferior, indican el tipo de plástico y facilitan el proceso de reciclaje. Lavado de Envases: Antes de reciclar, asegúrate de lavar bien los envases de plástico para eliminar cualquier residuo o contaminante. Esto garantiza un proceso de reciclaje más eficiente. Eliminación de Tapas y Etiquetas: Retira tapas y etiquetas de los envases de plástico antes de reciclarlos. Las tapas pueden estar hechas de diferentes materiales y deben reciclarse por separado, mientras que las etiquetas pueden interferir con el proceso. Compactado y Almacenamiento: Compacta los envases de plástico para reducir el espacio y facilitar el transporte. Almacénalos en bolsas reciclables o contenedores designados para el plástico hasta el día de la recolección. Recuerda, cada pequeña contribución cuenta, y el reciclaje del plástico es una manera tangible de marcar la diferencia en la salud de nuestro planeta. ¡Haz tu parte y recicla el plástico!',
    ),
    GuideData(
      background: const Color(0xFF69d2e7),
      title: 'Papeles & Cartones',
      titleshow: '¿Como reciclar papeles & cartones?',
      image: 'assets/2.png',
      imageshow: 'assets/item2.jpg',
      description:
          'Reciclar papel y cartón es una práctica esencial para reducir la cantidad de residuos sólidos y promover la sostenibilidad ambiental. El papel y el cartón son materiales reciclables que, cuando se gestionan adecuadamente, contribuyen a la conservación de recursos naturales, la disminución de la deforestación y la reducción de la energía necesaria para producir nuevos productos.',
    ),
    GuideData(
      background: const Color(0xFF459a96),
      title: 'Vidrio',
      titleshow: '¿Como reciclar el vidrio?',
      image: 'assets/3.png',
      imageshow: 'assets/item3.jpg',
      description:
          'Reciclar vidrio es una práctica fundamental para reducir el impacto ambiental y promover la sostenibilidad. El vidrio es un material reciclable al 100%, lo que significa que puede ser reutilizado una y otra vez sin perder calidad. Aquí te presento algunos pasos y consejos sobre cómo reciclar vidrio de manera efectiva.',
    ),
    GuideData(
      background: const Color(0xfffc9782),
      title: 'Materiales Peligrosos',
      titleshow: '¿Como reciclar materiales peligrosos?',
      image: 'assets/4.png',
      imageshow: 'assets/item4.jpg',
      description:
          'Reciclar materiales peligrosos es una práctica esencial para mitigar los impactos negativos que estos desechos pueden tener en el medio ambiente y en la salud humana. Los materiales peligrosos, como productos químicos tóxicos, baterías, aceites usados y productos electrónicos, requieren un manejo especializado debido a su potencial para causar daños significativos.',
    ),
    GuideData(
      background: const Color(0xFFe6a972),
      title: 'Residuos Orgánicos',
      titleshow: '¿Como reciclar residuos orgánicos?',
      image: 'assets/5.png',
      imageshow: 'assets/item5.jpg',
      description:
          'Reciclar residuos orgánicos es una práctica esencial para contribuir al cuidado del medio ambiente y reducir la cantidad de desechos que terminan en vertederos. Los residuos orgánicos, como restos de alimentos y materiales biodegradables, pueden transformarse en compost, un valioso abono natural que enriquece el suelo y mejora su fertilidad. Aquí te presento algunos pasos y consejos sobre cómo reciclar residuos orgánicos de manera efectiva.',
    ),
    GuideData(
      background: const Color(0xFFe1eae3),
      title: 'Varios',
      titleshow: '¿Como reciclar elementos variados?',
      image: 'assets/6.png',
      imageshow: 'assets/item6.jpg',
      description:
          'El reciclaje es una práctica fundamental para preservar nuestro medio ambiente y reducir el impacto negativo de nuestros desechos en el planeta. En este sentido, reciclar diversos materiales es esencial para promover un estilo de vida sostenible y contribuir a la conservación de los recursos naturales. A continuación, se presentan algunas pautas sobre cómo reciclar varios tipos de materiales comunes.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Guia de Reciclaje',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 8.0,
                children: List.generate(
                  guideDataList.length,
                  (index) {
                    return GuideItem(
                      title: guideDataList[index].title,
                      image: guideDataList[index].image,
                      background: guideDataList[index].background,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuideDetailsPage(
                                title: guideDataList[index].title,
                                image: guideDataList[index].imageshow,
                                info: guideDataList[index].description,
                                color: guideDataList[index].background,
                                box: guideDataList[index].titleshow),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
