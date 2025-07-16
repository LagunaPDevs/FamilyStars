// This class defines the different types of rewards available for a child user
class Reward{
  String? id;
  String? category;
  String? name;
  int? stars;

  Reward({
    this.id,
    this.category,
    this.name,
    this.stars
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
    id: json["id"],
    category: json["category"],
    name: json["name"],
    stars: json["stars"] != null ? int.parse(json["stars"]) : 0
  );

  factory Reward.fromNoJsonData() => Reward();

  Map<String, dynamic>  toJson() => {
    "id": id,
    "category": category, 
    "name": name,
    "stars": stars,
  };

}