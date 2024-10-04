//
//  HorizontalFolderView.swift
//  UISample
//
//  Created by haram on 7/17/24.
//

import Foundation
import UIKit

class HorizontalFolderView:UIStackView{
    var items:[FolderViewItem]?
    var defaultRow:Int?
    var col:Int?
    var action:((UIGestureRecognizer)->Void)?
    
    ///호출전 top, reading, trailing, width에 대한 오토레이아웃이 존재해야 정상적인 UI구성가능
    func initForderView(items:[FolderViewItem], defaultRow:Int, col:Int, action: ((UIGestureRecognizer)->Void)?){
        self.items = items
        self.defaultRow = defaultRow
        self.col = col
        self.action = action
        
        for i in 0..<defaultRow{
            var rowItems:[FolderViewItem] = []
            for j in 0..<col{
                let index = i*col+j
                
                if index >= items.count{ ///item이 더이상 존재하지 않는 경우
                    rowItems.append(FolderViewItem(type: .empty))
                    continue
                }
                
                if j == col-1 && i == defaultRow-1{ ///확장버튼을 추가해야 하는 경우
                    rowItems.append(FolderViewItem(type: .open))
                    continue
                }
                
                rowItems.append(items[index])
            }
            
            let row = makeCategoryRowView(rowItems:rowItems)
            self.addArrangedSubview(row)

        }
        
        
    }
    
    private func makeCategoryRowView(rowItems:[FolderViewItem]) -> UIStackView{
        let rowView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
        rowView.spacing = 15.adjustW
        rowItems.forEach{
            let cell = makeCategoryCellView(item: $0)
            rowView.addArrangedSubview(cell)
            
            cell.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(10)
            }
        
        }
        return rowView
    }
    
    private func makeCategoryCellView(item:FolderViewItem) -> UIStackView{
        
        let cellView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
        
        let imageView = UIImageView()
        imageView.snp.makeConstraints{ make in
            make.width.equalTo(45.adjustW)
            make.height.equalTo(45.adjustH)
        }
        
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.snp.makeConstraints{ make in
            make.width.equalTo(60.adjustW)
            make.height.equalTo(40.adjustH)
        }
        
        switch item.type{
        case .empty:
            let image = UIImage()
            imageView.image = image
            imageView.contentMode = .scaleToFill
            
            textView.text = ""

        case .open:
            let image = UIImage(systemName: "chevron.down")
            imageView.image = image
            imageView.contentMode = .scaleToFill
            imageView.tintColor = .black
            
            textView.text = "열림"

            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openForderView))
            
            cellView.isUserInteractionEnabled = true
            cellView.addGestureRecognizer(gestureRecognizer)
            
        case .close:
            let image = UIImage(systemName: "chevron.compact.up")
            imageView.image = image
            imageView.contentMode = .scaleToFill
            imageView.tintColor = .black

            textView.text = "닫힘"
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeForderView))
            
            cellView.isUserInteractionEnabled = true
            cellView.addGestureRecognizer(gestureRecognizer)
        
        case .normal:
            let image = UIImage(named: item.image ?? "")
            imageView.image = image
            imageView.contentMode = .scaleToFill
            
            textView.text = item.name
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToCategoryView(gesture:)))
            gestureRecognizer.name = item.name
            cellView.isUserInteractionEnabled = true
            cellView.addGestureRecognizer(gestureRecognizer)
        }
        
        cellView.addArrangedSubview(imageView)
        cellView.addArrangedSubview(textView)
        
        return cellView
    }
    
    @objc private func openForderView(){
        
        guard let items = self.items, let col = self.col, let defaultRow = self.defaultRow else{
            return
        }
        
        let openRow = self.arrangedSubviews[defaultRow-1] as! UIStackView
        let removeCell = openRow.arrangedSubviews[col-1]
        openRow.removeArrangedSubview(removeCell)
        removeCell.removeFromSuperview()
        
        openRow.addArrangedSubview(makeCategoryCellView(item: items[defaultRow*col-1]))
        
        let totalRow = (items.count/col) + (items.count%col > 0 ? 1:0) 
        for i in defaultRow..<totalRow{
            var arr:[FolderViewItem] = []
            for j in 0..<col{
                let index = i*col+j
                
                if i == totalRow-1 && j == col-1{
                    arr.append(FolderViewItem(type: .close))
                }
                else if index >= items.count{
                    arr.append(FolderViewItem(type: .empty))
                }
                else {
                    arr.append(items[index])
                }
            }
            
            let rowView = makeCategoryRowView(rowItems: arr)
            self.addArrangedSubview(rowView)
        }
    }
    
    @objc private func closeForderView(){
        print("closeForder")
        guard let items = self.items, let col = self.col, let defaultRow = self.defaultRow else{
            return
        }
        
        for i in stride(from: self.arrangedSubviews.count-1, to: defaultRow-1, by: -1){
            let removeRow = self.arrangedSubviews[i]
            self.removeArrangedSubview(removeRow)
            removeRow.removeFromSuperview()
        }
        
        
        //8번째 셀을 열림버튼으로 대치
        let openRow = self.arrangedSubviews[defaultRow-1] as! UIStackView
        let removeCell = openRow.arrangedSubviews[col-1]
        openRow.removeArrangedSubview(removeCell)
        removeCell.removeFromSuperview()
        
        openRow.addArrangedSubview(makeCategoryCellView(item: FolderViewItem(type: .open)))
        
    }
    
    @objc private func moveToCategoryView(gesture:UIGestureRecognizer){
        guard let action = self.action else{
            return 
        }
        
        let _ = action(gesture)
    }
}

struct FolderViewItem{
    enum type{
        case normal
        case empty
        case open
        case close
    }
    
    let type:type
    let name:String?
    let image:String?
    
    init(type:type){
        self.type = type
        self.name = nil
        self.image = nil
    }
    
    init(name:String, image:String){
        self.name = name
        self.image = image
        self.type = .normal
    }
}
