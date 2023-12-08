

class ReviewModel {
  String userName;
  String reviewText;
  DateTime? time;
  double ratingCount;
  String hourId;
  String userId;
  String? userImageUrl;
  List<Replies>? replies;
  bool showReplies;
  ReviewModel({required this.showReplies,required this.userName,required this.reviewText, this.time,required this.ratingCount,
      required this.hourId, required this.userId, required this.userImageUrl,required this.replies});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userName'] = userName;
    data['reviewText'] = reviewText;
    data['time'] = time??DateTime.now();
    data['ratingCount'] = ratingCount;
    data['hourId'] = hourId;
    data['userId'] = userId;
    data['showReplies'] = false;
    data['userImageUrl'] = userImageUrl;
    data['replies'] = replies == null?[]:replies!.map((e) => e.toJson()).toList();

    return data;
  }

  static ReviewModel fromDoc(Map<String, dynamic> data) {
    List<Replies> replies = [];


    if((data['replies'] as List).isNotEmpty){
      for(var reply in data['replies']){
        Replies replyModel = Replies.fromDoc(reply);
        replies.add(replyModel);
      }
    }
    return ReviewModel(
      showReplies: false,
      userName:data['userName'],
      reviewText:data['reviewText'],
      time: data['time']!= null? (data['time']).toDate():DateTime.now(),
      ratingCount:data['ratingCount'],
      hourId:data['hourId'],
      userId:data['userId'],
      userImageUrl:data['userImageUrl'],
      replies:replies,
    );
  }
}

class Replies {
  String? businessName;
  String replyText;
  DateTime? time;
  String hourId;
  String? userImageUrl;
  Replies(
      {required this.userImageUrl,
      required this.hourId,
      this.time,
      required this.businessName,
      required this.replyText});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessName']=businessName;
    data['replyText']=replyText;
    data['time']=time??DateTime.now();
    data['hourId']=hourId;
    data['userImageUrl']=userImageUrl;
    return data;
  }
  static Replies fromDoc(Map<String,dynamic>json){
    return Replies(
      businessName: json['businessName'],
      replyText: json['replyText'],
      time: json['time']!= null? (json['time']).toDate():DateTime.now(),
      hourId: json['hourId'],
      userImageUrl: json['userImageUrl'],
    );
  }
}
