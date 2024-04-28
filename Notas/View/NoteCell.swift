//
//  NoteCell.swift
//  Notas
//
//  Created by Abraham Valderrabano Vega on 25/04/24.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    
    
    @IBOutlet weak var noteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
