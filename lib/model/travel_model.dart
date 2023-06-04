///旅拍类别模型
class TravelTabModel {
  Map? params;
  String url;
  List<TravelTab> tabs;

  TravelTabModel({required this.url, required this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    List<TravelTab> list = [];
    if (json['tabs'] != null) {
      json['tabs'].forEach((v) {
        list.add(new TravelTab.fromJson(v));
      });
    }
    return TravelTabModel(
      url: json['url'] ?? '',
      tabs: list
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelTab {
  String labelName;
  String groupChannelCode;

  TravelTab({required this.labelName, required this.groupChannelCode});

  factory TravelTab.fromJson(Map<String, dynamic> json) {
    // labelName = json['labelName'] ?? '';
    // groupChannelCode = json['groupChannelCode'] ?? '';
    return TravelTab(
        labelName: json['labelName'] ?? '',
        groupChannelCode: json['groupChannelCode'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
