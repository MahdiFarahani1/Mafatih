import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/About_Us/widgets/widget_us.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: EsaySize.width(context) * 0.92,
            height: EsaySize.height(context) * 0.75,
            decoration: BoxDecoration(
                gradient: CustomGr.gradient(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      "تأسست الموسوعة الإسلامية الكومبيوترية سنة 1994م،وذلك لتحقيق هدف سامٍ، كان وراء توحيد طاقات الأخوة المؤمنين، في المجالين العلمي والتقني، لتعريف الأسرة المسلمة بمعالم الشريعة الإسلامية المقدسة، كما هي محددة الأبعاد عند أئمة أهل البيت (ع)، مع الاحتفاظ بمضمونها العلمي، مع دقّة العبارة وعمق الفكرة وسعت المؤسسة لسد الفراغ الحاصل في المكتبة الكومبيوترية العربية الشيعية،التي تعاني نقصا كبيرا في هذا المجال، خصوصا بعد أن أخذ الكومبيوتر حيزا كبيرا في حياة شبابنا، والذي تزامن مع الانتشار الهائل للبرامج الكومبيوترية باللغة العربية، فكانت هي المؤسسة الوحيدة المتخصصة بإنتاج البرامج العربية الشيعية، على شكل أقراص كومبيوترية مبرمجة بشكل فني وجذاب، آخذةً بنظر الاعتبار كافة المستويات الثقافية والعلمية، فكان نتاجها منبعاً ورافداً علمياً للمتخصصين والشبيبة الواعية وحتى الناشئين، لغرض إيصال هذا الفكر وتلك الكلمة إلى أكبر عدد ممكن من المسلمين المنتشرين في ربوع هذه المعمورة، في حين استطاعت العديد من المؤسسات العربية غير الشيعية أن تقوم بإنتاج البرامج الكومبيوترية وعلى كافة الأصعدة ولأجل النهوض بهذا المشروع الضخم وتحقيق أهدافه، ألفت لجان من أفاضل طلبة العلوم الدينية، واختصت كل لجنة بقسم من أقسام الموسوعة، فتولت جمع وتنسيق المعلومات المتعلقة به، ، وبفضل جهود ورعاية المشرف والمدير العام سماحة الشيخ جواد القوچانی كان نتاج الموسوعة مجموعة من الأقراص الكمبيوترية المبرمجة الصوتية والمرئية والمرتبطة بالهاتف النقال",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Btn.allbtn(context),
            ),
          )
        ],
      ),
    );
  }
}
