//
//  CalenderViewController.swift
//  Medl
//
//  Created by Ashish Soni on 19/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit
import FSCalendar
import CRNotifications
class CalenderViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {

    @IBOutlet weak var calenderView: FSCalendar!
    var strdate:String!
    var dates = Date()
    var dateFormatter: DateFormatter?
    var gregorian:Calendar!
    var datenew:Date!
    var componentsnew = DateComponents()
    var currentDatenew:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        calenderView.delegate = self
        calenderView.dataSource = self
        gregorian = Calendar(identifier: .gregorian)
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "dd MMM yyyy"
        let string = dateFormatter?.string(from: dates)
        currentDatenew = string
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
        //return monthPosition == .current
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
//                cell.isUserInteractionEnabled = false
//                cell.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
//            }else {
//                cell.isUserInteractionEnabled = true
//            }
            
            cell.isUserInteractionEnabled = true
            
        }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date)
        if day == 1 {
            return UIColor.lightGray
        }

        return nil //Considering default date color is black
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
            self.error(message: "Date not available.")
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
    
    
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        
//        let vc = Date.today().next(.sunday)
//        print(vc)
//        let dateString : String = dateFormatter!.string(from:vc)
//        let datein = dateFormatter?.date(from: dateString)
//        if calendar.currentPage == datein {
//             return .green
//        }else {
//           return nil
//        }
////
////          if self.somedays.contains(dateString) {
////              return .green
////          } else {
////              return nil
////          }
//    }
    
    
    // MARK: - Private functions
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Date {
    static func today() -> Date {
        return Date()
    }

    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
      return get(.next,
      weekday,
      considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {

      let dayName = weekDay.rawValue

      let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

      assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

      let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

      let calendar = Calendar(identifier: .gregorian)

      if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
        return self
      }

      var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
      nextDateComponent.weekday = searchWeekdayIndex

      let date = calendar.nextDate(after: self,
                                   matching: nextDateComponent,
                                   matchingPolicy: .nextTime,
                                   direction: direction.calendarSearchDirection)

      return date!
    }
    
    
}
extension Date {
    func getWeekDaysInEnglish() -> [String] {
      var calendar = Calendar(identifier: .gregorian)
      calendar.locale = Locale(identifier: "en_US_POSIX")
      return calendar.weekdaySymbols
    }
    enum Weekday: String {
      case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    enum SearchDirection {
        case next
        case previous

        var calendarSearchDirection: Calendar.SearchDirection {
          switch self {
          case .next:
            return .forward
          case .previous:
            return .backward
          }
        }
      }
    
}
