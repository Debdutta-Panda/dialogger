import 'package:mobx/mobx.dart';

import 'extensions.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModel with _$HomePageViewModel;

abstract class _HomePageViewModel with Store {

  @observable
  DialogTrigger showDialog = DialogTrigger();

  @action
  onClick(){
    openDialog();
  }

  openDialog() async{
    var result = await triggerDialog((d)=>showDialog = d,value:"My message");
    print(result);
  }
}

//flutter pub run build_runner build