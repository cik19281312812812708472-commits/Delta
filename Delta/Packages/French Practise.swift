//
//  Untitled.swift
//  Delta
//
//  Created by Desire on 2026-05-26.
//

import TestCreation
import Combine

class FrenchPractise: Package {
    
    var publicName: String = "French Conjugation"
    
    var internalName: String = "FrenchPractise"
    
    var packageDescription: String = "A package to practise french conjugation. This is semi helped by AI get the data for conjugatio questions, the rest is human."
    
    var id: UUID = UUID()
    
    var allChangbleBools: [TestCreation.boolSetting] = []
    
    var allChangbleInts: [TestCreation.intSetting] = [intSetting(int: 286, name: "Number of questions")]
    
    var allChangbleDoubles: [TestCreation.doubleSetting] = []
    
    var allQuestions: [Question] = []
    var createdAllQuestions: Bool = false
    var createdAllSettings: Bool = false
    
    func updateInternalSettings() {
        if allChangbleInts[0].int < 0 {
            allChangbleInts[0].int = 0
        }
    }
    
    func filterAnswer(answer: String) -> String {
        return answer.lowercased()
    }
    
    func createRestofSettings() {
        
      
            for question in allQuestions {
                
                let newBoolSetting = boolSetting(bool: false, name: "Ommit question \"\(question.questionText)\"")
               // print(newBoolSetting)
                allChangbleBools.append(newBoolSetting)
                //print(allChangbleBools)
            }
          
        
    }
    func setup() {
        createAllQuestions()
        createRestofSettings()
        
        allChangbleInts[0].int = allQuestions.count
        
    }
    
    init() {
        setup()
    }
    
    
    func createAllQuestions() {
        
        
        for question in AllQuestionTypes.allCases {
           
            let theQuestion = question.Question
            
            let content = QuestionContent {}
            
            let trueQuestion = Question(creator: self.id, questionText: "Conjugate: \(theQuestion.Verb) | for \(theQuestion.Noun)", questionContent: content, questionContentSizeX: 0, questionContentSizeY: 0, questionAnswer: theQuestion.Answer)
            
            
            allQuestions.append(trueQuestion)
            
            
        }
        createdAllQuestions = true
    }
    
    func createSection(numOfQuestions: Int) -> [TestCreation.Question] {
        
    
        
        
        
        var section: [Question] = []
        
        var finishedCreatingSection = false
        var i = 0
        var actualIndex = 0
        while finishedCreatingSection == false {
            
            if i > allQuestions.count - 1 {
                i = 0
            }
            if actualIndex > allChangbleInts[0].int {
                finishedCreatingSection = true
            }
            
            
            
            if allChangbleBools[i].bool == false {
                section.append(allQuestions[i])
                
            }
            
            
            i += 1
            actualIndex += 1
        }
        
        
        
        
        
        
        
        return section
    }
    
    func createQuestion() -> TestCreation.Question {
        
        return allQuestions.randomElement()!
    }
    
    
    
    struct conjugationQuestion {
        var Verb: String
        var Noun: String
        var Answer: String
        
        init(Verb: String, Noun: String, Answer: String) {
            self.Verb = Verb
            self.Noun = Noun
            self.Answer = Answer
        }
    }
    
    
    
    
    enum AllQuestionTypes: CaseIterable {
        
        // ==== EXISTING ORIGINAL CASES ====
        case DevoirJe, DevoirTu, DevoirIl, DevoirElle, DevoirOn, DevoirIls, DevoirElles, DevoirNous, DevoirVous
        case PouvoirJe, PouvoirTu, PouvoirIl, PouvoirElle, PouvoirIls, PouvoirElles, PouvoirOn, PouvoirNous, PouvoirVous
        case VouloirJe, VouloirTu, VouloirIl, VouloirElle, VouloirOn, VouloirIls, VouloirElles, VouloirNous, VouloirVous
        case AvoirJe, AvoirTu, AvoirIl, AvoirNous, AvoirVous, AvoirElles
        case pu, du, voulu, ete
        case AllerJe, AllerTu, AllerIl, AllerNous, AllerVous, AllerElles
        case EtreJe, EtreTu, EtreIl, EtreElle, EtreOn, EtreNous, EtreVous, EtreIls, EtreElles
        
        // ==== EXPANDED IMPARFAIT CASES ====
        case ImparfaitChanterJe, ImparfaitChanterTu, ImparfaitChanterIl, ImparfaitChanterElle, ImparfaitChanterOn, ImparfaitChanterNous, ImparfaitChanterVous, ImparfaitChanterIls, ImparfaitChanterElles
        case ImparfaitFinirJe, ImparfaitFinirTu, ImparfaitFinirIl, ImparfaitFinirElle, ImparfaitFinirOn, ImparfaitFinirNous, ImparfaitFinirVous, ImparfaitFinirIls, ImparfaitFinirElles
        case ImparfaitVendreJe, ImparfaitVendreTu, ImparfaitVendreIl, ImparfaitVendreElle, ImparfaitVendreOn, ImparfaitVendreNous, ImparfaitVendreVous, ImparfaitVendreIls, ImparfaitVendreElles
        case ImparfaitAvoirJe, ImparfaitAvoirTu, ImparfaitAvoirIl, ImparfaitAvoirElle, ImparfaitAvoirOn, ImparfaitAvoirNous, ImparfaitAvoirVous, ImparfaitAvoirIls, ImparfaitAvoirElles
        case ImparfaitEtreJe, ImparfaitEtreTu, ImparfaitEtreIl, ImparfaitEtreElle, ImparfaitEtreOn, ImparfaitEtreNous, ImparfaitEtreVous, ImparfaitEtreIls, ImparfaitEtreElles
        case ImparfaitAllerJe, ImparfaitAllerTu, ImparfaitAllerIl, ImparfaitAllerElle, ImparfaitAllerOn, ImparfaitAllerNous, ImparfaitAllerVous, ImparfaitAllerIls, ImparfaitAllerElles
        case ImparfaitFaireJe, ImparfaitFaireTu, ImparfaitFaireIl, ImparfaitFaireElle, ImparfaitFaireOn, ImparfaitFaireNous, ImparfaitFaireVous, ImparfaitFaireIls, ImparfaitFaireElles
        case ImparfaitDevoirJe, ImparfaitDevoirTu, ImparfaitDevoirIl, ImparfaitDevoirElle, ImparfaitDevoirOn, ImparfaitDevoirNous, ImparfaitDevoirVous, ImparfaitDevoirIls, ImparfaitDevoirElles
        case ImparfaitVoirJe, ImparfaitVoirTu, ImparfaitVoirIl, ImparfaitVoirElle, ImparfaitVoirOn, ImparfaitVoirNous, ImparfaitVoirVous, ImparfaitVoirIls, ImparfaitVoirElles
        case ImparfaitVouloirJe, ImparfaitVouloirTu, ImparfaitVouloirIl, ImparfaitVouloirElle, ImparfaitVouloirOn, ImparfaitVouloirNous, ImparfaitVouloirVous, ImparfaitVouloirIls, ImparfaitVouloirElles
        case ImparfaitPouvoirJe, ImparfaitPouvoirTu, ImparfaitPouvoirIl, ImparfaitPouvoirElle, ImparfaitPouvoirOn, ImparfaitPouvoirNous, ImparfaitPouvoirVous, ImparfaitPouvoirIls, ImparfaitPouvoirElles
        case ImparfaitSavoirJe, ImparfaitSavoirTu, ImparfaitSavoirIl, ImparfaitSavoirElle, ImparfaitSavoirOn, ImparfaitSavoirNous, ImparfaitSavoirVous, ImparfaitSavoirIls, ImparfaitSavoirElles
        case ImparfaitEcrireJe, ImparfaitEcrireTu, ImparfaitEcrireIl, ImparfaitEcrireElle, ImparfaitEcrireOn, ImparfaitEcrireNous, ImparfaitEcrireVous, ImparfaitEcrireIls, ImparfaitEcrireElles
        case ImparfaitDireJe, ImparfaitDireTu, ImparfaitDireIl, ImparfaitDireElle, ImparfaitDireOn, ImparfaitDireNous, ImparfaitDireVous, ImparfaitDireIls, ImparfaitDireElles
        case ImparfaitLireJe, ImparfaitLireTu, ImparfaitLireIl, ImparfaitLireElle, ImparfaitLireOn, ImparfaitLireNous, ImparfaitLireVous, ImparfaitLireIls, ImparfaitLireElles
        case ImparfaitOuvrirJe, ImparfaitOuvrirTu, ImparfaitOuvrirIl, ImparfaitOuvrirElle, ImparfaitOuvrirOn, ImparfaitOuvrirNous, ImparfaitOuvrirVous, ImparfaitOuvrirIls, ImparfaitOuvrirElles
        case ImparfaitVenirJe, ImparfaitVenirTu, ImparfaitVenirIl, ImparfaitVenirElle, ImparfaitVenirOn, ImparfaitVenirNous, ImparfaitVenirVous, ImparfaitVenirIls, ImparfaitVenirElles
        case ImparfaitMangerJe, ImparfaitMangerTu, ImparfaitMangerIl, ImparfaitMangerElle, ImparfaitMangerOn, ImparfaitMangerNous, ImparfaitMangerVous, ImparfaitMangerIls, ImparfaitMangerElles
        case ImparfaitMettreJe, ImparfaitMettreTu, ImparfaitMettreIl, ImparfaitMettreElle, ImparfaitMettreOn, ImparfaitMettreNous, ImparfaitMettreVous, ImparfaitMettreIls, ImparfaitMettreElles
        case ImparfaitPendreJe, ImparfaitPendreTu, ImparfaitPendreIl, ImparfaitPendreElle, ImparfaitPendreOn, ImparfaitPendreNous, ImparfaitPendreVous, ImparfaitPendreIls, ImparfaitPendreElles

        // ==== EXPANDED MODAL CASES ====
        case ShouldJe, ShouldTu, ShouldIl, ShouldElle, ShouldOn, ShouldNous, ShouldVous, ShouldIls, ShouldElles
        case CouldJe, CouldTu, CouldIl, CouldElle, CouldOn, CouldNous, CouldVous, CouldIls, CouldElles
        case MustJe, MustTu, MustIl, MustElle, MustOn, MustNous, MustVous, MustIls, MustElles

        // ==== EXPANDED GENERAL TERMINATIONS (Present Tense Suffixes) ====
        case TerminaisonERJe, TerminaisonERTu, TerminaisonERIl, TerminaisonERElle, TerminaisonEROn, TerminaisonERNous, TerminaisonERVous, TerminaisonERIls, TerminaisonERElles
        case TerminaisonIRJe, TerminaisonIRTu, TerminaisonIRIl, TerminaisonIRElle, TerminaisonIROn, TerminaisonIRNous, TerminaisonIRVous, TerminaisonIRIls, TerminaisonIRElles
        case TerminaisonREJe, TerminaisonRETu, TerminaisonREIl, TerminaisonREElle, TerminaisonREOn, TerminaisonRENous, TerminaisonREVous, TerminaisonREIls, TerminaisonREElles

        var Question: conjugationQuestion {
            switch self {
            // ==== ORIGINAL SWITCH CASES (UNTOUCHED) ====
            case .DevoirJe: return .init(Verb: "Devoir", Noun: "Je", Answer: "dois")
            case .DevoirTu: return .init(Verb: "Devoir", Noun: "Tu", Answer: "dois")
            case .DevoirIl: return .init(Verb: "Devoir", Noun: "Il", Answer: "doit")
            case .DevoirElle: return .init(Verb: "Devoir", Noun: "Elle", Answer: "doit")
            case .DevoirOn: return .init(Verb: "Devoir", Noun: "On", Answer: "doit")
            case .DevoirIls: return .init(Verb: "Devoir", Noun: "Ils", Answer: "doivent")
            case .DevoirElles: return .init(Verb: "Devoir", Noun: "Elles", Answer: "doivent")
            case .DevoirNous: return .init(Verb: "Devoir", Noun: "Nous", Answer: "devons")
            case .DevoirVous: return .init(Verb: "Devoir", Noun: "Vous", Answer: "devez")
            case .PouvoirJe: return .init(Verb: "Pouvoir", Noun: "Je", Answer: "peux")
            case .PouvoirTu: return .init(Verb: "Pouvoir", Noun: "Tu", Answer: "peux")
            case .PouvoirIl: return .init(Verb: "Pouvoir", Noun: "Il", Answer: "peut")
            case .PouvoirElle: return .init(Verb: "Pouvoir", Noun: "Elle", Answer: "peut")
            case .PouvoirIls: return .init(Verb: "Pouvoir", Noun: "Ils", Answer: "peuvent")
            case .PouvoirElles: return .init(Verb: "Pouvoir", Noun: "Elles", Answer: "peuvent")
            case .PouvoirOn: return .init(Verb: "Pouvoir", Noun: "On", Answer: "peut")
            case .PouvoirNous: return .init(Verb: "Pouvoir", Noun: "Nous", Answer: "pouvons")
            case .PouvoirVous: return .init(Verb: "Pouvoir", Noun: "Vous", Answer: "pouvez")
            case .VouloirJe: return .init(Verb: "Vouloir", Noun: "Je", Answer: "veux")
            case .VouloirTu: return .init(Verb: "Vouloir", Noun: "Tu", Answer: "veux")
            case .VouloirIl: return .init(Verb: "Vouloir", Noun: "Il", Answer: "veut")
            case .VouloirElle: return .init(Verb: "Vouloir", Noun: "Elle", Answer: "veut")
            case .VouloirOn: return .init(Verb: "Vouloir", Noun: "On", Answer: "veut")
            case .VouloirIls: return .init(Verb: "Vouloir", Noun: "Ils", Answer: "veulent")
            case .VouloirElles: return .init(Verb: "Vouloir", Noun: "Elles", Answer: "veulent")
            case .VouloirNous: return .init(Verb: "Vouloir", Noun: "Nous", Answer: "voulons")
            case .VouloirVous: return .init(Verb: "Vouloir", Noun: "Vous", Answer: "voulez")
            case .AvoirJe: return .init(Verb: "Avoir", Noun: "Je", Answer: "ai")
            case .AvoirTu: return .init(Verb: "Avoir", Noun: "Tu", Answer: "as")
            case .AvoirIl: return .init(Verb: "Avoir", Noun: "Il/Elle/On", Answer: "a")
            case .AvoirNous: return .init(Verb: "Avoir", Noun: "Nous", Answer: "avons")
            case .AvoirVous: return .init(Verb: "Avoir", Noun: "Vous", Answer: "avez")
            case .AvoirElles: return .init(Verb: "Avoir", Noun: "Ils/Elles", Answer: "ont")
            case .pu: return .init(Verb: "Pouvoir", Noun: "Passe Composée", Answer: "pu")
            case .du: return .init(Verb: "Devoir", Noun: "Passe Composée", Answer: "dû")
            case .voulu: return .init(Verb: "Vouloir", Noun: "Passe Composée", Answer: "voulu")
            case .ete: return .init(Verb: "Etre", Noun: "Passe Composée", Answer: "été")
            case .AllerJe: return .init(Verb: "Aller", Noun: "Je", Answer: "vais")
            case .AllerTu: return .init(Verb: "Aller", Noun: "Tu", Answer: "vas")
            case .AllerIl: return .init(Verb: "Aller", Noun: "Il/Elle/On", Answer: "va")
            case .AllerNous: return .init(Verb: "Aller", Noun: "Nous", Answer: "allons")
            case .AllerVous: return .init(Verb: "Aller", Noun: "Vous", Answer: "allez")
            case .AllerElles: return .init(Verb: "Aller", Noun: "Ils/Elles", Answer: "vont")
            case .EtreJe: return .init(Verb: "Etre", Noun: "Je", Answer: "suis")
            case .EtreTu: return .init(Verb: "Etre", Noun: "Tu", Answer: "es")
            case .EtreIl: return .init(Verb: "Etre", Noun: "Il", Answer: "est")
            case .EtreElle: return .init(Verb: "Etre", Noun: "Elle", Answer: "est")
            case .EtreOn: return .init(Verb: "Etre", Noun: "On", Answer: "est")
            case .EtreNous: return .init(Verb: "Etre", Noun: "Nous", Answer: "sommes")
            case .EtreVous: return .init(Verb: "Etre", Noun: "Vous", Answer: "êtes")
            case .EtreIls: return .init(Verb: "Etre", Noun: "Ils", Answer: "sont")
            case .EtreElles: return .init(Verb: "Etre", Noun: "Elles", Answer: "sont")
                
            // ==== SOLUTIONS : IMPARFAIT ====
            case .ImparfaitChanterJe: return .init(Verb: "Chanter (Imparfait)", Noun: "Je", Answer: "chantais")
            case .ImparfaitChanterTu: return .init(Verb: "Chanter (Imparfait)", Noun: "Tu", Answer: "chantais")
            case .ImparfaitChanterIl: return .init(Verb: "Chanter (Imparfait)", Noun: "Il", Answer: "chantait")
            case .ImparfaitChanterElle: return .init(Verb: "Chanter (Imparfait)", Noun: "Elle", Answer: "chantait")
            case .ImparfaitChanterOn: return .init(Verb: "Chanter (Imparfait)", Noun: "On", Answer: "chantait")
            case .ImparfaitChanterNous: return .init(Verb: "Chanter (Imparfait)", Noun: "Nous", Answer: "chantions")
            case .ImparfaitChanterVous: return .init(Verb: "Chanter (Imparfait)", Noun: "Vous", Answer: "chantiez")
            case .ImparfaitChanterIls: return .init(Verb: "Chanter (Imparfait)", Noun: "Ils", Answer: "chantaient")
            case .ImparfaitChanterElles: return .init(Verb: "Chanter (Imparfait)", Noun: "Elles", Answer: "chantaient")

            case .ImparfaitFinirJe: return .init(Verb: "Finir (Imparfait)", Noun: "Je", Answer: "finissais")
            case .ImparfaitFinirTu: return .init(Verb: "Finir (Imparfait)", Noun: "Tu", Answer: "finissais")
            case .ImparfaitFinirIl: return .init(Verb: "Finir (Imparfait)", Noun: "Il", Answer: "finissait")
            case .ImparfaitFinirElle: return .init(Verb: "Finir (Imparfait)", Noun: "Elle", Answer: "finissait")
            case .ImparfaitFinirOn: return .init(Verb: "Finir (Imparfait)", Noun: "On", Answer: "finissait")
            case .ImparfaitFinirNous: return .init(Verb: "Finir (Imparfait)", Noun: "Nous", Answer: "finissions")
            case .ImparfaitFinirVous: return .init(Verb: "Finir (Imparfait)", Noun: "Vous", Answer: "finissiez")
            case .ImparfaitFinirIls: return .init(Verb: "Finir (Imparfait)", Noun: "Ils", Answer: "finissaient")
            case .ImparfaitFinirElles: return .init(Verb: "Finir (Imparfait)", Noun: "Elles", Answer: "finissaient")

            case .ImparfaitVendreJe: return .init(Verb: "Vendre (Imparfait)", Noun: "Je", Answer: "vendais")
            case .ImparfaitVendreTu: return .init(Verb: "Vendre (Imparfait)", Noun: "Tu", Answer: "vendais")
            case .ImparfaitVendreIl: return .init(Verb: "Vendre (Imparfait)", Noun: "Il", Answer: "vendait")
            case .ImparfaitVendreElle: return .init(Verb: "Vendre (Imparfait)", Noun: "Elle", Answer: "vendait")
            case .ImparfaitVendreOn: return .init(Verb: "Vendre (Imparfait)", Noun: "On", Answer: "vendait")
            case .ImparfaitVendreNous: return .init(Verb: "Vendre (Imparfait)", Noun: "Nous", Answer: "vendions")
            case .ImparfaitVendreVous: return .init(Verb: "Vendre (Imparfait)", Noun: "Vous", Answer: "vendiez")
            case .ImparfaitVendreIls: return .init(Verb: "Vendre (Imparfait)", Noun: "Ils", Answer: "vendaient")
            case .ImparfaitVendreElles: return .init(Verb: "Vendre (Imparfait)", Noun: "Elles", Answer: "vendaient")

            case .ImparfaitAvoirJe: return .init(Verb: "Avoir (Imparfait)", Noun: "Je", Answer: "avais")
            case .ImparfaitAvoirTu: return .init(Verb: "Avoir (Imparfait)", Noun: "Tu", Answer: "avais")
            case .ImparfaitAvoirIl: return .init(Verb: "Avoir (Imparfait)", Noun: "Il", Answer: "avait")
            case .ImparfaitAvoirElle: return .init(Verb: "Avoir (Imparfait)", Noun: "Elle", Answer: "avait")
            case .ImparfaitAvoirOn: return .init(Verb: "Avoir (Imparfait)", Noun: "On", Answer: "avait")
            case .ImparfaitAvoirNous: return .init(Verb: "Avoir (Imparfait)", Noun: "Nous", Answer: "avions")
            case .ImparfaitAvoirVous: return .init(Verb: "Avoir (Imparfait)", Noun: "Vous", Answer: "aviez")
            case .ImparfaitAvoirIls: return .init(Verb: "Avoir (Imparfait)", Noun: "Ils", Answer: "avaient")
            case .ImparfaitAvoirElles: return .init(Verb: "Avoir (Imparfait)", Noun: "Elles", Answer: "avaient")

            case .ImparfaitEtreJe: return .init(Verb: "Être (Imparfait)", Noun: "Je", Answer: "étais")
            case .ImparfaitEtreTu: return .init(Verb: "Être (Imparfait)", Noun: "Tu", Answer: "étais")
            case .ImparfaitEtreIl: return .init(Verb: "Être (Imparfait)", Noun: "Il", Answer: "était")
            case .ImparfaitEtreElle: return .init(Verb: "Être (Imparfait)", Noun: "Elle", Answer: "était")
            case .ImparfaitEtreOn: return .init(Verb: "Être (Imparfait)", Noun: "On", Answer: "était")
            case .ImparfaitEtreNous: return .init(Verb: "Être (Imparfait)", Noun: "Nous", Answer: "étiez")
            case .ImparfaitEtreVous: return .init(Verb: "Être (Imparfait)", Noun: "Vous", Answer: "étiez")
            case .ImparfaitEtreIls: return .init(Verb: "Être (Imparfait)", Noun: "Ils", Answer: "étaient")
            case .ImparfaitEtreElles: return .init(Verb: "Être (Imparfait)", Noun: "Elles", Answer: "étaient")

            case .ImparfaitAllerJe: return .init(Verb: "Aller (Imparfait)", Noun: "Je", Answer: "allais")
            case .ImparfaitAllerTu: return .init(Verb: "Aller (Imparfait)", Noun: "Tu", Answer: "allais")
            case .ImparfaitAllerIl: return .init(Verb: "Aller (Imparfait)", Noun: "Il", Answer: "allait")
            case .ImparfaitAllerElle: return .init(Verb: "Aller (Imparfait)", Noun: "Elle", Answer: "allait")
            case .ImparfaitAllerOn: return .init(Verb: "Aller (Imparfait)", Noun: "On", Answer: "allait")
            case .ImparfaitAllerNous: return .init(Verb: "Aller (Imparfait)", Noun: "Nous", Answer: "allions")
            case .ImparfaitAllerVous: return .init(Verb: "Aller (Imparfait)", Noun: "Vous", Answer: "alliez")
            case .ImparfaitAllerIls: return .init(Verb: "Aller (Imparfait)", Noun: "Ils", Answer: "allaient")
            case .ImparfaitAllerElles: return .init(Verb: "Aller (Imparfait)", Noun: "Elles", Answer: "allaient")

            case .ImparfaitFaireJe: return .init(Verb: "Faire (Imparfait)", Noun: "Je", Answer: "faisais")
            case .ImparfaitFaireTu: return .init(Verb: "Faire (Imparfait)", Noun: "Tu", Answer: "faisais")
            case .ImparfaitFaireIl: return .init(Verb: "Faire (Imparfait)", Noun: "Il", Answer: "faisait")
            case .ImparfaitFaireElle: return .init(Verb: "Faire (Imparfait)", Noun: "Elle", Answer: "faisait")
            case .ImparfaitFaireOn: return .init(Verb: "Faire (Imparfait)", Noun: "On", Answer: "faisait")
            case .ImparfaitFaireNous: return .init(Verb: "Faire (Imparfait)", Noun: "Nous", Answer: "faisions")
            case .ImparfaitFaireVous: return .init(Verb: "Faire (Imparfait)", Noun: "Vous", Answer: "faisiez")
            case .ImparfaitFaireIls: return .init(Verb: "Faire (Imparfait)", Noun: "Ils", Answer: "faisaient")
            case .ImparfaitFaireElles: return .init(Verb: "Faire (Imparfait)", Noun: "Elles", Answer: "faisaient")

            case .ImparfaitDevoirJe: return .init(Verb: "Devoir (Imparfait)", Noun: "Je", Answer: "devais")
            case .ImparfaitDevoirTu: return .init(Verb: "Devoir (Imparfait)", Noun: "Tu", Answer: "devais")
            case .ImparfaitDevoirIl: return .init(Verb: "Devoir (Imparfait)", Noun: "Il", Answer: "devait")
            case .ImparfaitDevoirElle: return .init(Verb: "Devoir (Imparfait)", Noun: "Elle", Answer: "devait")
            case .ImparfaitDevoirOn: return .init(Verb: "Devoir (Imparfait)", Noun: "On", Answer: "devait")
            case .ImparfaitDevoirNous: return .init(Verb: "Devoir (Imparfait)", Noun: "Nous", Answer: "devions")
            case .ImparfaitDevoirVous: return .init(Verb: "Devoir (Imparfait)", Noun: "Vous", Answer: "deviez")
            case .ImparfaitDevoirIls: return .init(Verb: "Devoir (Imparfait)", Noun: "Ils", Answer: "devaient")
            case .ImparfaitDevoirElles: return .init(Verb: "Devoir (Imparfait)", Noun: "Elles", Answer: "devaient")

            case .ImparfaitVoirJe: return .init(Verb: "Voir (Imparfait)", Noun: "Je", Answer: "voyais")
            case .ImparfaitVoirTu: return .init(Verb: "Voir (Imparfait)", Noun: "Tu", Answer: "voyais")
            case .ImparfaitVoirIl: return .init(Verb: "Voir (Imparfait)", Noun: "Il", Answer: "voyait")
            case .ImparfaitVoirElle: return .init(Verb: "Voir (Imparfait)", Noun: "Elle", Answer: "voyait")
            case .ImparfaitVoirOn: return .init(Verb: "Voir (Imparfait)", Noun: "On", Answer: "voyait")
            case .ImparfaitVoirNous: return .init(Verb: "Voir (Imparfait)", Noun: "Nous", Answer: "voyions")
            case .ImparfaitVoirVous: return .init(Verb: "Voir (Imparfait)", Noun: "Vous", Answer: "voyiez")
            case .ImparfaitVoirIls: return .init(Verb: "Voir (Imparfait)", Noun: "Ils", Answer: "voyaient")
            case .ImparfaitVoirElles: return .init(Verb: "Voir (Imparfait)", Noun: "Elles", Answer: "voyaient")

            case .ImparfaitVouloirJe: return .init(Verb: "Vouloir (Imparfait)", Noun: "Je", Answer: "voulais")
            case .ImparfaitVouloirTu: return .init(Verb: "Vouloir (Imparfait)", Noun: "Tu", Answer: "voulais")
            case .ImparfaitVouloirIl: return .init(Verb: "Vouloir (Imparfait)", Noun: "Il", Answer: "voulait")
            case .ImparfaitVouloirElle: return .init(Verb: "Vouloir (Imparfait)", Noun: "Elle", Answer: "voulait")
            case .ImparfaitVouloirOn: return .init(Verb: "Vouloir (Imparfait)", Noun: "On", Answer: "voulait")
            case .ImparfaitVouloirNous: return .init(Verb: "Vouloir (Imparfait)", Noun: "Nous", Answer: "voulions")
            case .ImparfaitVouloirVous: return .init(Verb: "Vouloir (Imparfait)", Noun: "Vous", Answer: "vouliez")
            case .ImparfaitVouloirIls: return .init(Verb: "Vouloir (Imparfait)", Noun: "Ils", Answer: "voulaient")
            case .ImparfaitVouloirElles: return .init(Verb: "Vouloir (Imparfait)", Noun: "Elles", Answer: "voulaient")

            case .ImparfaitPouvoirJe: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Je", Answer: "pouvais")
            case .ImparfaitPouvoirTu: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Tu", Answer: "pouvais")
            case .ImparfaitPouvoirIl: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Il", Answer: "pouvait")
            case .ImparfaitPouvoirElle: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Elle", Answer: "pouvait")
            case .ImparfaitPouvoirOn: return .init(Verb: "Pouvoir (Imparfait)", Noun: "On", Answer: "pouvait")
            case .ImparfaitPouvoirNous: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Nous", Answer: "pouvions")
            case .ImparfaitPouvoirVous: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Vous", Answer: "pouviez")
            case .ImparfaitPouvoirIls: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Ils", Answer: "pouvaient")
            case .ImparfaitPouvoirElles: return .init(Verb: "Pouvoir (Imparfait)", Noun: "Elles", Answer: "pouvaient")

            case .ImparfaitSavoirJe: return .init(Verb: "Savoir (Imparfait)", Noun: "Je", Answer: "savais")
            case .ImparfaitSavoirTu: return .init(Verb: "Savoir (Imparfait)", Noun: "Tu", Answer: "savais")
            case .ImparfaitSavoirIl: return .init(Verb: "Savoir (Imparfait)", Noun: "Il", Answer: "savait")
            case .ImparfaitSavoirElle: return .init(Verb: "Savoir (Imparfait)", Noun: "Elle", Answer: "savait")
            case .ImparfaitSavoirOn: return .init(Verb: "Savoir (Imparfait)", Noun: "On", Answer: "savait")
            case .ImparfaitSavoirNous: return .init(Verb: "Savoir (Imparfait)", Noun: "Nous", Answer: "savions")
            case .ImparfaitSavoirVous: return .init(Verb: "Savoir (Imparfait)", Noun: "Vous", Answer: "saviez")
            case .ImparfaitSavoirIls: return .init(Verb: "Savoir (Imparfait)", Noun: "Ils", Answer: "savaient")
            case .ImparfaitSavoirElles: return .init(Verb: "Savoir (Imparfait)", Noun: "Elles", Answer: "savaient")

            case .ImparfaitEcrireJe: return .init(Verb: "Écrire (Imparfait)", Noun: "Je", Answer: "écrivais")
            case .ImparfaitEcrireTu: return .init(Verb: "Écrire (Imparfait)", Noun: "Tu", Answer: "écrivais")
            case .ImparfaitEcrireIl: return .init(Verb: "Écrire (Imparfait)", Noun: "Il", Answer: "écrivait")
            case .ImparfaitEcrireElle: return .init(Verb: "Écrire (Imparfait)", Noun: "Elle", Answer: "écrivait")
            case .ImparfaitEcrireOn: return .init(Verb: "Écrire (Imparfait)", Noun: "On", Answer: "écrivait")
            case .ImparfaitEcrireNous: return .init(Verb: "Écrire (Imparfait)", Noun: "Nous", Answer: "écrivions")
            case .ImparfaitEcrireVous: return .init(Verb: "Écrire (Imparfait)", Noun: "Vous", Answer: "écriviez")
            case .ImparfaitEcrireIls: return .init(Verb: "Écrire (Imparfait)", Noun: "Ils", Answer: "écrivaient")
            case .ImparfaitEcrireElles: return .init(Verb: "Écrire (Imparfait)", Noun: "Elles", Answer: "écrivaient")

            case .ImparfaitDireJe: return .init(Verb: "Dire (Imparfait)", Noun: "Je", Answer: "disais")
            case .ImparfaitDireTu: return .init(Verb: "Dire (Imparfait)", Noun: "Tu", Answer: "disais")
            case .ImparfaitDireIl: return .init(Verb: "Dire (Imparfait)", Noun: "Il", Answer: "disait")
            case .ImparfaitDireElle: return .init(Verb: "Dire (Imparfait)", Noun: "Elle", Answer: "disait")
            case .ImparfaitDireOn: return .init(Verb: "Dire (Imparfait)", Noun: "On", Answer: "disait")
            case .ImparfaitDireNous: return .init(Verb: "Dire (Imparfait)", Noun: "Nous", Answer: "disions")
            case .ImparfaitDireVous: return .init(Verb: "Dire (Imparfait)", Noun: "Vous", Answer: "disiez")
            case .ImparfaitDireIls: return .init(Verb: "Dire (Imparfait)", Noun: "Ils", Answer: "disaient")
            case .ImparfaitDireElles: return .init(Verb: "Dire (Imparfait)", Noun: "Elles", Answer: "disaient")

            case .ImparfaitLireJe: return .init(Verb: "Lire (Imparfait)", Noun: "Je", Answer: "lisais")
            case .ImparfaitLireTu: return .init(Verb: "Lire (Imparfait)", Noun: "Tu", Answer: "lisais")
            case .ImparfaitLireIl: return .init(Verb: "Lire (Imparfait)", Noun: "Il", Answer: "lisait")
            case .ImparfaitLireElle: return .init(Verb: "Lire (Imparfait)", Noun: "Elle", Answer: "lisait")
            case .ImparfaitLireOn: return .init(Verb: "Lire (Imparfait)", Noun: "On", Answer: "lisait")
            case .ImparfaitLireNous: return .init(Verb: "Lire (Imparfait)", Noun: "Nous", Answer: "lisions")
            case .ImparfaitLireVous: return .init(Verb: "Lire (Imparfait)", Noun: "Vous", Answer: "lisiez")
            case .ImparfaitLireIls: return .init(Verb: "Lire (Imparfait)", Noun: "Ils", Answer: "disaient")
            case .ImparfaitLireElles: return .init(Verb: "Lire (Imparfait)", Noun: "Elles", Answer: "lisaient")

            case .ImparfaitOuvrirJe: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Je", Answer: "ouvrais")
            case .ImparfaitOuvrirTu: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Tu", Answer: "ouvrais")
            case .ImparfaitOuvrirIl: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Il", Answer: "ouvrait")
            case .ImparfaitOuvrirElle: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Elle", Answer: "ouvrait")
            case .ImparfaitOuvrirOn: return .init(Verb: "Ouvrir (Imparfait)", Noun: "On", Answer: "ouvrait")
            case .ImparfaitOuvrirNous: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Nous", Answer: "ouvrions")
            case .ImparfaitOuvrirVous: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Vous", Answer: "ouvriez")
            case .ImparfaitOuvrirIls: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Ils", Answer: "ouvraient")
            case .ImparfaitOuvrirElles: return .init(Verb: "Ouvrir (Imparfait)", Noun: "Elles", Answer: "ouvraient")

            case .ImparfaitVenirJe: return .init(Verb: "Venir (Imparfait)", Noun: "Je", Answer: "venais")
            case .ImparfaitVenirTu: return .init(Verb: "Venir (Imparfait)", Noun: "Tu", Answer: "venais")
            case .ImparfaitVenirIl: return .init(Verb: "Venir (Imparfait)", Noun: "Il", Answer: "venait")
            case .ImparfaitVenirElle: return .init(Verb: "Venir (Imparfait)", Noun: "Elle", Answer: "venait")
            case .ImparfaitVenirOn: return .init(Verb: "Venir (Imparfait)", Noun: "On", Answer: "venait")
            case .ImparfaitVenirNous: return .init(Verb: "Venir (Imparfait)", Noun: "Nous", Answer: "venions")
            case .ImparfaitVenirVous: return .init(Verb: "Venir (Imparfait)", Noun: "Vous", Answer: "veniez")
            case .ImparfaitVenirIls: return .init(Verb: "Venir (Imparfait)", Noun: "Ils", Answer: "venaient")
            case .ImparfaitVenirElles: return .init(Verb: "Venir (Imparfait)", Noun: "Elles", Answer: "venaient")

            case .ImparfaitMangerJe: return .init(Verb: "Manger (Imparfait)", Noun: "Je", Answer: "mangeais")
            case .ImparfaitMangerTu: return .init(Verb: "Manger (Imparfait)", Noun: "Tu", Answer: "mangeais")
            case .ImparfaitMangerIl: return .init(Verb: "Manger (Imparfait)", Noun: "Il", Answer: "mangeait")
            case .ImparfaitMangerElle: return .init(Verb: "Manger (Imparfait)", Noun: "Elle", Answer: "mangeait")
            case .ImparfaitMangerOn: return .init(Verb: "Manger (Imparfait)", Noun: "On", Answer: "mangeait")
            case .ImparfaitMangerNous: return .init(Verb: "Manger (Imparfait)", Noun: "Nous", Answer: "mangiions")
            case .ImparfaitMangerVous: return .init(Verb: "Manger (Imparfait)", Noun: "Vous", Answer: "mangiez")
            case .ImparfaitMangerIls: return .init(Verb: "Manger (Imparfait)", Noun: "Ils", Answer: "mangeaient")
            case .ImparfaitMangerElles: return .init(Verb: "Manger (Imparfait)", Noun: "Elles", Answer: "mangeaient")

            case .ImparfaitMettreJe: return .init(Verb: "Mettre (Imparfait)", Noun: "Je", Answer: "mettais")
            case .ImparfaitMettreTu: return .init(Verb: "Mettre (Imparfait)", Noun: "Tu", Answer: "mettais")
            case .ImparfaitMettreIl: return .init(Verb: "Mettre (Imparfait)", Noun: "Il", Answer: "mettait")
            case .ImparfaitMettreElle: return .init(Verb: "Mettre (Imparfait)", Noun: "Elle", Answer: "mettait")
            case .ImparfaitMettreOn: return .init(Verb: "Mettre (Imparfait)", Noun: "On", Answer: "mettait")
            case .ImparfaitMettreNous: return .init(Verb: "Mettre (Imparfait)", Noun: "Nous", Answer: "mettions")
            case .ImparfaitMettreVous: return .init(Verb: "Mettre (Imparfait)", Noun: "Vous", Answer: "mettiez")
            case .ImparfaitMettreIls: return .init(Verb: "Mettre (Imparfait)", Noun: "Ils", Answer: "mettaient")
            case .ImparfaitMettreElles: return .init(Verb: "Mettre (Imparfait)", Noun: "Elles", Answer: "mettaient")

            case .ImparfaitPendreJe: return .init(Verb: "Pendre (Imparfait)", Noun: "Je", Answer: "pendais")
            case .ImparfaitPendreTu: return .init(Verb: "Pendre (Imparfait)", Noun: "Tu", Answer: "pendais")
            case .ImparfaitPendreIl: return .init(Verb: "Pendre (Imparfait)", Noun: "Il", Answer: "pendait")
            case .ImparfaitPendreElle: return .init(Verb: "Pendre (Imparfait)", Noun: "Elle", Answer: "pendait")
            case .ImparfaitPendreOn: return .init(Verb: "Pendre (Imparfait)", Noun: "On", Answer: "pendait")
            case .ImparfaitPendreNous: return .init(Verb: "Pendre (Imparfait)", Noun: "Nous", Answer: "pendions")
            case .ImparfaitPendreVous: return .init(Verb: "Pendre (Imparfait)", Noun: "Vous", Answer: "pendiez")
            case .ImparfaitPendreIls: return .init(Verb: "Pendre (Imparfait)", Noun: "Ils", Answer: "pendaient")
            case .ImparfaitPendreElles: return .init(Verb: "Pendre (Imparfait)", Noun: "Elles", Answer: "pendaient")
                
            // ==== SOLUTIONS : MODALS (Should / Could / Must) ====
            case .ShouldJe: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Je", Answer: "devrais")
            case .ShouldTu: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Tu", Answer: "devrais")
            case .ShouldIl: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Il", Answer: "devrait")
            case .ShouldElle: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Elle", Answer: "devrait")
            case .ShouldOn: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "On", Answer: "devrait")
            case .ShouldNous: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Nous", Answer: "devrions")
            case .ShouldVous: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Vous", Answer: "devriez")
            case .ShouldIls: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Ils", Answer: "devraient")
            case .ShouldElles: return .init(Verb: "Devoir (Should / Conditionnel)", Noun: "Elles", Answer: "devraient")

            case .CouldJe: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Je", Answer: "pourrais")
            case .CouldTu: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Tu", Answer: "pourrais")
            case .CouldIl: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Il", Answer: "pourrait")
            case .CouldElle: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Elle", Answer: "pourrait")
            case .CouldOn: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "On", Answer: "pourrait")
            case .CouldNous: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Nous", Answer: "pourrions")
            case .CouldVous: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Vous", Answer: "pourriez")
            case .CouldIls: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Ils", Answer: "pourraient")
            case .CouldElles: return .init(Verb: "Pouvoir (Could / Conditionnel)", Noun: "Elles", Answer: "pourraient")

            case .MustJe: return .init(Verb: "Devoir (Must / Présent)", Noun: "Je", Answer: "dois")
            case .MustTu: return .init(Verb: "Devoir (Must / Présent)", Noun: "Tu", Answer: "dois")
            case .MustIl: return .init(Verb: "Devoir (Must / Présent)", Noun: "Il", Answer: "doit")
            case .MustElle: return .init(Verb: "Devoir (Must / Présent)", Noun: "Elle", Answer: "doit")
            case .MustOn: return .init(Verb: "Devoir (Must / Présent)", Noun: "On", Answer: "doit")
            case .MustNous: return .init(Verb: "Devoir (Must / Présent)", Noun: "Nous", Answer: "devons")
            case .MustVous: return .init(Verb: "Devoir (Must / Présent)", Noun: "Vous", Answer: "devez")
            case .MustIls: return .init(Verb: "Devoir (Must / Présent)", Noun: "Ils", Answer: "doivent")
            case .MustElles: return .init(Verb: "Devoir (Must / Présent)", Noun: "Elles", Answer: "doivent")
                
            // ==== SOLUTIONS : PRESENT TENSE TERMINATIONS ====
            case .TerminaisonERJe: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Je", Answer: "-e")
            case .TerminaisonERTu: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Tu", Answer: "-es")
            case .TerminaisonERIl: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Il", Answer: "-e")
            case .TerminaisonERElle: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Elle", Answer: "-e")
            case .TerminaisonEROn: return .init(Verb: "Verbes en -ER (Présent)", Noun: "On", Answer: "-e")
            case .TerminaisonERNous: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Nous", Answer: "-ons")
            case .TerminaisonERVous: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Vous", Answer: "-ez")
            case .TerminaisonERIls: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Ils", Answer: "-ent")
            case .TerminaisonERElles: return .init(Verb: "Verbes en -ER (Présent)", Noun: "Elles", Answer: "-ent")

            case .TerminaisonIRJe: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Je", Answer: "-is")
            case .TerminaisonIRTu: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Tu", Answer: "-is")
            case .TerminaisonIRIl: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Il", Answer: "-it")
            case .TerminaisonIRElle: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Elle", Answer: "-it")
            case .TerminaisonIROn: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "On", Answer: "-it")
            case .TerminaisonIRNous: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Nous", Answer: "-issons")
            case .TerminaisonIRVous: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Vous", Answer: "-issez")
            case .TerminaisonIRIls: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Ils", Answer: "-issent")
            case .TerminaisonIRElles: return .init(Verb: "Verbes en -IR réguliers (Présent)", Noun: "Elles", Answer: "-issent")

            case .TerminaisonREJe: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Je", Answer: "-s")
            case .TerminaisonRETu: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Tu", Answer: "-s")
            case .TerminaisonREIl: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Il", Answer: "-(rien)")
            case .TerminaisonREElle: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Elle", Answer: "-(rien)")
            case .TerminaisonREOn: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "On", Answer: "-(rien)")
            case .TerminaisonRENous: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Nous", Answer: "-ons")
            case .TerminaisonREVous: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Vous", Answer: "-ez")
            case .TerminaisonREIls: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Ils", Answer: "-ent")
            case .TerminaisonREElles: return .init(Verb: "Verbes en -RE réguliers (Présent)", Noun: "Elles", Answer: "-ent")
            }
        }
    }
    
}
