import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.appbar(true, context),
      body: Column(
        children: [
          aboutUs(context),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
              //    Btn.allbtn(context)
            ),
          )
        ],
      ),
    );
  }

  Container aboutUs(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: EsaySize.width(context) * 0.92,
      height: EsaySize.height(context) * 0.75,
      decoration: BoxDecoration(
          gradient: CustomGr.gradient(context),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
                "بسم الله الرحمن الرحيم الحمد لله رب العالمين والصلاة والسلام على محمد واله الطيبن الطاهرين تأسست الموسوعة الإسلامية الكومبيوترية سنة 1994م،وذلك لتحقيق هدف سامٍ، كان وراء توحيد طاقات الأخوة المؤمنين، في المجالين العلمي والتقني، لتعريف الأسرة المسلمة بمعالم الشريعة الإسلامية المقدسة، كما هي محددة الأبعاد عند أئمة أهل البيت (ع)، مع الاحتفاظ بمضمونها العلمي، مع دقّة العبارة وعمق الفكرة وسعت المؤسسة لسد الفراغ الحاصل في المكتبة الكومبيوترية العربية الشيعية، ولأجل النهوض بهذا المشروع الضخم وتحقيق أهدافه، ألفت لجان من أفاضل طلبة العلوم الدينية، واختصت كل لجنة بقسم من أقسام الموسوعة، فتولت جمع وتنسيق المعلومات المتعلقة به، ، وبفضل جهود ورعاية المدير العام سماحة الشيخ جواد القوچاني كان نتاج الموسوعة مجموعة من الأقراص الكمبيوترية المبرمجة الصوتية والمرئية والمرتبطة بالهاتف النقال تتقدم الموسوعة الإسلامية الكومبيوترية بالشكر الجزيل، إلى جميع الإخوة الذين ساهموا في إنجاز هذا البرنامج، راجية لهم دوام الموفقية",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
