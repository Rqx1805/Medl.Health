//
//  CalenderIPADViewController.swift
//  Medl
//
//  Created by Ashish Soni on 19/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit
import FSCalendar
import CRNotifications
class CalenderIPADViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    @IBOutlet weak var calenderView: FSCalendar!
    var strdate:String!
    var dates = Date()
    var dateFormatter: DateFormatter?
    var gregorian:Calendar!
    var datenew:Date!
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderView.delegate = self
        calenderView.dataSource = self
        
        gregorian = Calendar(identifier: .gregorian)
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "dd MMM yyyy"
        let string = dateFormatter?.string(from: dates)
        print("Date is \(String(describing: string))")
        
        let calendarnew = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendarnew
        
        components.day = 3
        datenew = calendarnew.date(byAdding: components, to: currentDate)!
        

        // Do any additional setup after loading the view.
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
             return CheckSatSunday(today: date)
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    //        print("did select date \(self.dateFormatter?.string(from: date))")
            strdate = (dateFormatter?.string(from: date))
            UserDefaults.standard.set(strdate, forKey: "date")
            if monthPosition == FSCalendarMonthPosition.next || monthPosition == FSCalendarMonthPosition.previous || monthPosition == FSCalendarMonthPosition.current {
                calendar.setCurrentPage(date, animated: true)
                self.calenderView.reloadData()
            }else {
           
            }
            navigationController?.popViewController(animated: true)
           
        }

        func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
            
//            let result: ComparisonResult? = date.compare(dates)
//            if result == .orderedAscending {
//
//                cell.isUserInteractionEnabled = false
//                cell.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
//            } else {
//                cell.isUserInteractionEnabled = true
//            }
             cell.isUserInteractionEnabled = true
        }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
          return datenew
      }
     
      
      func CheckSatSunday(today:Date) ->Bool{

          var DayExist:Bool
          // let today = NSDate()

          let calendar =
              NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
          let components = calendar!.components([.weekday], from: today)

          if components.weekday == 1 {
              print("Sunday")
              self.error(message: "Delivery is not available on sunday.")
              DayExist = false
          } else{
              print("It's not Saturday and  Sunday ")
              DayExist = true
          }
          print("weekday :\(String(describing: components.weekday)) ")
          return DayExist
      }
    func error(message: String){
           CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
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
