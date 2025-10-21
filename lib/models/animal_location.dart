class AnimalLocation {
  String? id;
  String? animalId;
  String? nomeAnimal;
  double? latitude;
  double? longitude;
  String? timestamp;
  String? status; 
  double? accuracy;
  String? batteryLevel;
  String? signalStrength; 

  AnimalLocation({
    this.id,
    this.animalId,
    this.nomeAnimal,
    this.latitude,
    this.longitude,
    this.timestamp,
    this.status,
    this.accuracy,
    this.batteryLevel,
    this.signalStrength,
  });

  factory AnimalLocation.fromMap(Map<String, dynamic> map) {
    return AnimalLocation(
      id: map['id'],
      animalId: map['animalId'],
      nomeAnimal: map['nomeAnimal'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      timestamp: map['timestamp'],
      status: map['status'],
      accuracy: map['accuracy']?.toDouble(),
      batteryLevel: map['batteryLevel'],
      signalStrength: map['signalStrength'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'animalId': animalId,
      'nomeAnimal': nomeAnimal,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
      'status': status,
      'accuracy': accuracy,
      'batteryLevel': batteryLevel,
      'signalStrength': signalStrength,
    };
  }

  bool isValid() {
    return latitude != null && 
           longitude != null && 
           latitude! >= -90 && 
           latitude! <= 90 &&
           longitude! >= -180 && 
           longitude! <= 180;
  }

  bool isRecent() {
    if (timestamp == null) return false;
    
    try {
      final locationTime = DateTime.parse(timestamp!);
      final now = DateTime.now();
      final difference = now.difference(locationTime);
      
      return difference.inMinutes <= 5;
    } catch (e) {
      return false;
    }
  }

  int getLocationAgeInMinutes() {
    if (timestamp == null) return -1;
    
    try {
      final locationTime = DateTime.parse(timestamp!);
      final now = DateTime.now();
      final difference = now.difference(locationTime);
      
      return difference.inMinutes;
    } catch (e) {
      return -1;
    }
  }

  @override
  String toString() {
    return 'AnimalLocation{id: $id, animalId: $animalId, nomeAnimal: $nomeAnimal, latitude: $latitude, longitude: $longitude, timestamp: $timestamp, status: $status}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnimalLocation && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
