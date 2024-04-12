class QuestionData {
  List<Question>? question;
  String? message;

  QuestionData({this.question, this.message});

  QuestionData.fromJson(Map<String, dynamic> json) {
    if (json['question'] != null) {
      question = <Question>[];
      json['question'].forEach((v) {
        question!.add(new Question.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Question {
  int? id;
  int? isomoId;
  String? question;
  String? options;
  String? answer;
  String? fileUpload;
  String? marks;
  String? clientId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Question(
      {this.id,
        this.isomoId,
        this.question,
        this.options,
        this.answer,
        this.fileUpload,
        this.marks,
        this.clientId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isomoId = int.tryParse(json['isomoId']);
    question = json['question'];
    options = json['options'];
    answer = json['answer'];
    fileUpload = json['fileUpload'];
    marks = json['marks'];
    clientId = json['client_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isomoId'] = this.isomoId;
    data['question'] = this.question;
    data['options'] = this.options;
    data['answer'] = this.answer;
    data['fileUpload'] = this.fileUpload;
    data['marks'] = this.marks;
    data['client_id'] = this.clientId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
