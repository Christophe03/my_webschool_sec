class ParentModel {
  String? adresse;
  String? code;
  String? email;
  int? id;
  String? nom;
  String? prenom;
  String? quartier;
  String? sexe;
  String? statut;
  String? tel1;
  String? tel2;
  String? ville;

  ParentModel(
    this.adresse,
    this.code,
    this.email,
    this.id,
    this.nom,
    this.prenom,
    this.quartier,
    this.sexe,
    this.statut,
    this.tel1,
    this.tel2,
    this.ville,
  );

  // Constructeur par défaut
  static ParentModel defaultParent() {
    return ParentModel(
      '', // adresse par défaut
      '', // code par défaut
      '', // email par défaut
      0, // id par défaut
      '', // nom par défaut
      '', // prénom par défaut
      '', // quartier par défaut
      '', // sexe par défaut
      '', // statut par défaut
      '', // tel1 par défaut
      null, // tel2 par défaut
      '', // ville par défaut
    );
  }
}
