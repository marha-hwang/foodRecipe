//
//  RecipeResponseDTO+Mapping.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

struct RecipeResponseDTO:Decodable{
    private enum CodingKeys: String, CodingKey {
        case COOKRCP = "COOKRCP01"
    }
    let COOKRCP:RecipeListDTO
}

extension RecipeResponseDTO{
    struct RecipeListDTO:Decodable{
        let total_count:String
        let row:[RecipeDTO]
        let RESULT:ResponseDTO
    }
}

extension RecipeResponseDTO{
    struct ResponseDTO:Decodable{
        let MSG:String
        let CODE:String
    }
}

extension RecipeResponseDTO{
    struct RecipeDTO:Decodable{
        let RCP_PARTS_DTLS:String
        let ATT_FILE_NO_MAIN:String
        let RCP_WAY2:String
        let MANUAL_IMG20:String
        let MANUAL20:String
        let RCP_SEQ:String
        let INFO_NA:String
        let INFO_WGT:String
        let INFO_PRO:String
        let INFO_FAT:String
        let HASH_TAG:String
        let RCP_PAT2:String
        let ATT_FILE_NO_MK:String
        let INFO_CAR:String
        let RCP_NM:String
        let INFO_ENG:String
        let RCP_NA_TIP:String
        let MANUAL_IMG01:String
        let MANUAL_IMG02:String
        let MANUAL_IMG03:String
        let MANUAL_IMG04:String
        let MANUAL_IMG05:String
        let MANUAL_IMG06:String
        let MANUAL_IMG07:String
        let MANUAL_IMG08:String
        let MANUAL_IMG09:String
        let MANUAL_IMG10:String
        let MANUAL_IMG11:String
        let MANUAL_IMG12:String
        let MANUAL_IMG13:String
        let MANUAL_IMG14:String
        let MANUAL_IMG15:String
        let MANUAL_IMG16:String
        let MANUAL_IMG17:String
        let MANUAL_IMG18:String
        let MANUAL_IMG19:String
        let MANUAL01:String
        let MANUAL02:String
        let MANUAL03:String
        let MANUAL04:String
        let MANUAL05:String
        let MANUAL06:String
        let MANUAL07:String
        let MANUAL08:String
        let MANUAL09:String
        let MANUAL10:String
        let MANUAL11:String
        let MANUAL12:String
        let MANUAL13:String
        let MANUAL14:String
        let MANUAL15:String
        let MANUAL16:String
        let MANUAL17:String
        let MANUAL18:String
        let MANUAL19:String
        
    }
}

extension RecipeResponseDTO{
    func toDomain(perPage:Int) -> RecipePage{
        return RecipePage(
            perPage:perPage,
            total_count: Int(COOKRCP.total_count) ?? 0,
            recpies: COOKRCP.row.map{$0.toDomain()}
        )
    }
}

extension RecipeResponseDTO.RecipeDTO{
    func toDomain() -> Recipe{
        var manual:[ManualItem] = []
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG01), description: MANUAL01))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG02), description: MANUAL02))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG03), description: MANUAL03))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG04), description: MANUAL04))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG05), description: MANUAL05))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG06), description: MANUAL06))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG07), description: MANUAL07))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG08), description: MANUAL08))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG09), description: MANUAL09))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG10), description: MANUAL10))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG11), description: MANUAL11))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG12), description: MANUAL12))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG13), description: MANUAL13))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG14), description: MANUAL14))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG15), description: MANUAL15))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG16), description: MANUAL16))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG17), description: MANUAL17))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG18), description: MANUAL18))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG19), description: MANUAL19))
        manual.append(ManualItem(imageUrl: formmationgURL(url: MANUAL_IMG20), description: MANUAL20))
        
        return Recipe(
            ingredients: RCP_PARTS_DTLS,
            main_image: "https" + ATT_FILE_NO_MAIN.getString(4, ATT_FILE_NO_MAIN.count),   
            cookWay: RCP_WAY2,
            recipe_type: RCP_PAT2,
            recipe_tip: RCP_NA_TIP,
            hash_tag: HASH_TAG,
            info_wgt: INFO_WGT,
            info_na: INFO_NA,
            info_pro: INFO_PRO,
            info_fat: INFO_FAT,
            info_cal: INFO_CAR,
            info_eng: INFO_ENG,
            recipe_seq: RCP_SEQ,
            recipe_name: RCP_NM,
            manual: manual
        )
    }
    
    func formmationgURL(url:String)->String{
        return url == "" ? "":"https" + url.getString(4, url.count)
    }
}
