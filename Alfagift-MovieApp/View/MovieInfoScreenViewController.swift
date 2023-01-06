//
//  MovieInfoScreenViewController.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/01/23.
//

import UIKit

class MovieInfoScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#if DEBUG
import SwiftUI
struct MovieInfoScreenController_Preview : PreviewProvider {
    static var previews: some View{
        ViewControllerPreview {
            MovieInfoScreenViewController()
        }
    }
}


#endif
