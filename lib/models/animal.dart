enum AnimalSex { male, female }
enum AnimalOrigin { internal, purchased }
enum ReproductiveStatus { 
  maleApt, 
  femaleInCycle, 
  pregnant, 
  lactating, 
  dry, 
  castrated, 
  infertile 
}
enum SaleStatus { available, sold, destinedForSlaughter, reserved }

class Animal {
  // 1. Identificação
  final String id; // ID interno único
  final String sisbovCode; // Código SISBOV (15 dígitos)
  final String electronicId; // Brinco eletrônico / chip RFID
  final String qrCode; // QR Code
  final String? name; // Nome do animal (opcional)
  final String currentLot; // Número de lote/piquete atual

  // 2. Dados Básicos
  final AnimalSex sex;
  final String breed;
  final DateTime birthDate;
  final String coatColor; // Pelagem/cor
  final String markings; // Marcações físicas
  final AnimalOrigin origin;

  // 3. Filiação e Genética
  final String? fatherId;
  final String? fatherName;
  final String? fatherRegistration;
  final String? motherId;
  final String? motherName;
  final String? motherRegistration;
  final String? pedigree;
  final String? breedCertification;
  final String? genomicData;

  // 4. Características Físicas
  final List<WeightRecord> weightHistory;
  final double? heightAtWithers; // Altura na cernelha
  final double? chestCircumference; // Circunferência torácica
  final int? bodyConditionScore; // Escore corporal (1-5)
  final double? scrotalCircumference; // Perímetro escrotal

  // 5. Dados Sanitários
  final List<VaccinationRecord> vaccinationHistory;
  final List<TreatmentRecord> treatmentHistory;
  final List<LaboratoryExam> laboratoryExams;
  final List<DiseaseRecord> diseaseHistory;
  final List<QuarantineRecord> quarantineHistory;

  // 6. Reprodução
  final ReproductiveStatus reproductiveStatus;
  final List<BreedingRecord> breedingHistory;
  final List<PregnancyRecord> pregnancyHistory;
  final List<BirthRecord> birthHistory;
  final List<LactationRecord> lactationHistory;

  // 7. Performance Zootécnica
  final List<PerformanceRecord> performanceHistory;
  final double? averageDailyGain; // GMD
  final double? feedConversion;
  final double? milkProduction; // Litros/dia
  final Map<String, double> milkQuality; // CCS, gordura, proteína

  // 8. Rastreabilidade e Movimentações
  final String currentLocation; // Fazenda atual
  final List<MovementRecord> movementHistory;
  final List<String> gtaNumbers; // GTAs vinculadas
  final List<GeofencingEvent> geofencingEvents;

  // 9. Documentação
  final List<String> photoUrls;
  final List<String> videoUrls;
  final List<DocumentAttachment> documents;

  // 10. Gestão Comercial e Financeira
  final double? acquisitionValue;
  final double? accumulatedMaintenanceCost;
  final double? generatedRevenue;
  final SaleStatus saleStatus;
  final double? saleValue;
  final DateTime? saleDate;

  // 11. Outros Dados Estratégicos
  final Map<String, dynamic> welfareIndicators;
  final Map<String, dynamic> esgIndicators;
  final String? insurancePolicy;
  final String? observations;

  // Campos de controle
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String updatedBy;

  Animal({
    required this.id,
    required this.sisbovCode,
    required this.electronicId,
    required this.qrCode,
    this.name,
    required this.currentLot,
    required this.sex,
    required this.breed,
    required this.birthDate,
    required this.coatColor,
    required this.markings,
    required this.origin,
    this.fatherId,
    this.fatherName,
    this.fatherRegistration,
    this.motherId,
    this.motherName,
    this.motherRegistration,
    this.pedigree,
    this.breedCertification,
    this.genomicData,
    this.weightHistory = const [],
    this.heightAtWithers,
    this.chestCircumference,
    this.bodyConditionScore,
    this.scrotalCircumference,
    this.vaccinationHistory = const [],
    this.treatmentHistory = const [],
    this.laboratoryExams = const [],
    this.diseaseHistory = const [],
    this.quarantineHistory = const [],
    required this.reproductiveStatus,
    this.breedingHistory = const [],
    this.pregnancyHistory = const [],
    this.birthHistory = const [],
    this.lactationHistory = const [],
    this.performanceHistory = const [],
    this.averageDailyGain,
    this.feedConversion,
    this.milkProduction,
    this.milkQuality = const {},
    required this.currentLocation,
    this.movementHistory = const [],
    this.gtaNumbers = const [],
    this.geofencingEvents = const [],
    this.photoUrls = const [],
    this.videoUrls = const [],
    this.documents = const [],
    this.acquisitionValue,
    this.accumulatedMaintenanceCost,
    this.generatedRevenue,
    required this.saleStatus,
    this.saleValue,
    this.saleDate,
    this.welfareIndicators = const {},
    this.esgIndicators = const {},
    this.insurancePolicy,
    this.observations,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  // Getters calculados
  int get ageInDays => DateTime.now().difference(birthDate).inDays;
  int get ageInMonths => (ageInDays / 30.44).floor();
  int get ageInYears => (ageInDays / 365.25).floor();
  
  double? get currentWeight => weightHistory.isNotEmpty 
      ? weightHistory.last.weight 
      : null;

  // Método para criar dados de exemplo
  static List<Animal> getSampleAnimals() {
    final now = DateTime.now();
    return [
      Animal(
        id: '001',
        sisbovCode: 'BR123456789012345',
        electronicId: 'EID001',
        qrCode: 'QR001',
        name: 'ROBSON',
        currentLot: 'LOTE-A',
        sex: AnimalSex.male,
        breed: 'Nelore',
        birthDate: DateTime(2022, 3, 15),
        coatColor: 'Branco',
        markings: 'Ferro na coxa esquerda',
        origin: AnimalOrigin.internal,
        reproductiveStatus: ReproductiveStatus.maleApt,
        currentLocation: 'Fazenda São José',
        saleStatus: SaleStatus.available,
        createdAt: now,
        updatedAt: now,
        createdBy: 'admin',
        updatedBy: 'admin',
        weightHistory: [
          WeightRecord(weight: 450.0, date: DateTime(2024, 1, 15), responsible: 'Dr. Silva'),
        ],
        vaccinationHistory: [
          VaccinationRecord(
            vaccine: 'Aftosa',
            dose: '1ª dose',
            date: DateTime(2024, 1, 10),
            responsible: 'Dr. Silva',
            batch: 'LOT001',
          ),
        ],
      ),
      Animal(
        id: '002',
        sisbovCode: 'BR123456789012346',
        electronicId: 'EID002',
        qrCode: 'QR002',
        name: 'MARIA',
        currentLot: 'LOTE-B',
        sex: AnimalSex.female,
        breed: 'Gir',
        birthDate: DateTime(2021, 8, 22),
        coatColor: 'Amarelo',
        markings: 'Tatuagem 1234',
        origin: AnimalOrigin.purchased,
        reproductiveStatus: ReproductiveStatus.pregnant,
        currentLocation: 'Fazenda São José',
        saleStatus: SaleStatus.available,
        createdAt: now,
        updatedAt: now,
        createdBy: 'admin',
        updatedBy: 'admin',
        weightHistory: [
          WeightRecord(weight: 380.0, date: DateTime(2024, 1, 15), responsible: 'Dr. Silva'),
        ],
        pregnancyHistory: [
          PregnancyRecord(
            conceptionDate: DateTime(2023, 10, 15),
            expectedBirthDate: DateTime(2024, 7, 15),
            bullUsed: 'Touro Nelore 001',
            method: 'Monta natural',
          ),
        ],
      ),
    ];
  }
}

// Classes auxiliares para registros históricos
class WeightRecord {
  final double weight;
  final DateTime date;
  final String responsible;

  WeightRecord({
    required this.weight,
    required this.date,
    required this.responsible,
  });
}

class VaccinationRecord {
  final String vaccine;
  final String dose;
  final DateTime date;
  final String responsible;
  final String batch;
  final String? notes;

  VaccinationRecord({
    required this.vaccine,
    required this.dose,
    required this.date,
    required this.responsible,
    required this.batch,
    this.notes,
  });
}

class TreatmentRecord {
  final String medication;
  final String dosage;
  final String reason;
  final DateTime date;
  final String responsible;
  final String? notes;

  TreatmentRecord({
    required this.medication,
    required this.dosage,
    required this.reason,
    required this.date,
    required this.responsible,
    this.notes,
  });
}

class LaboratoryExam {
  final String examType;
  final DateTime date;
  final String result;
  final String laboratory;
  final String responsible;

  LaboratoryExam({
    required this.examType,
    required this.date,
    required this.result,
    required this.laboratory,
    required this.responsible,
  });
}

class DiseaseRecord {
  final String disease;
  final DateTime diagnosisDate;
  final String symptoms;
  final String treatment;
  final DateTime? recoveryDate;
  final String veterinarian;

  DiseaseRecord({
    required this.disease,
    required this.diagnosisDate,
    required this.symptoms,
    required this.treatment,
    this.recoveryDate,
    required this.veterinarian,
  });
}

class QuarantineRecord {
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String location;
  final String responsible;

  QuarantineRecord({
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.location,
    required this.responsible,
  });
}

class BreedingRecord {
  final DateTime date;
  final String method; // Monta natural, IA, FIV
  final String? bullId;
  final String? bullName;
  final String responsible;
  final bool successful;

  BreedingRecord({
    required this.date,
    required this.method,
    this.bullId,
    this.bullName,
    required this.responsible,
    required this.successful,
  });
}

class PregnancyRecord {
  final DateTime conceptionDate;
  final DateTime expectedBirthDate;
  final String? bullUsed;
  final String method;
  final DateTime? actualBirthDate;
  final String? notes;

  PregnancyRecord({
    required this.conceptionDate,
    required this.expectedBirthDate,
    this.bullUsed,
    required this.method,
    this.actualBirthDate,
    this.notes,
  });
}

class BirthRecord {
  final DateTime date;
  final String type; // Normal, cesariana, etc.
  final bool liveBirth;
  final int numberOfOffspring;
  final String? notes;

  BirthRecord({
    required this.date,
    required this.type,
    required this.liveBirth,
    required this.numberOfOffspring,
    this.notes,
  });
}

class LactationRecord {
  final DateTime startDate;
  final DateTime? endDate;
  final double dailyProduction; // Litros/dia
  final Map<String, double> quality; // CCS, gordura, proteína
  final String? notes;

  LactationRecord({
    required this.startDate,
    this.endDate,
    required this.dailyProduction,
    this.quality = const {},
    this.notes,
  });
}

class PerformanceRecord {
  final DateTime date;
  final double weight;
  final double? averageDailyGain;
  final double? feedConversion;
  final String? notes;

  PerformanceRecord({
    required this.date,
    required this.weight,
    this.averageDailyGain,
    this.feedConversion,
    this.notes,
  });
}

class MovementRecord {
  final DateTime date;
  final String fromLocation;
  final String toLocation;
  final String reason;
  final String gtaNumber;
  final String responsible;

  MovementRecord({
    required this.date,
    required this.fromLocation,
    required this.toLocation,
    required this.reason,
    required this.gtaNumber,
    required this.responsible,
  });
}

class GeofencingEvent {
  final DateTime date;
  final String eventType; // Exit, Entry, Alert
  final String location;
  final String? notes;

  GeofencingEvent({
    required this.date,
    required this.eventType,
    required this.location,
    this.notes,
  });
}

class DocumentAttachment {
  final String id;
  final String name;
  final String type;
  final String url;
  final DateTime uploadDate;
  final String uploadedBy;

  DocumentAttachment({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.uploadDate,
    required this.uploadedBy,
  });
}
