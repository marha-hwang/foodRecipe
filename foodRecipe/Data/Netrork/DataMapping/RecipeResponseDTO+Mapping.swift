//
//  RecipeResponseDTO+Mapping.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

struct RecipeResponseDTO:Decodable{
    let COOKRCP01:RecipeListDTO
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
