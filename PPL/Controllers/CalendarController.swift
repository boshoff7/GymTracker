//
//  CalendarController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/31.
//

import UIKit

class CalendarController: UIViewController {
    
    // MARK: - Initializers
    var isSelected: Bool = false
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCalendar()
    }
    
    
    // MARK: - Calendar Setup
    private func displayCalendar() {
        let calendarView                                        = UICalendarView()
        calendarView.calendar                                   = Calendar(identifier: .gregorian)
        calendarView.translatesAutoresizingMaskIntoConstraints  = false
        calendarView.delegate                                   = self
        calendarView.backgroundColor                            = .systemGray3
        calendarView.layer.cornerRadius                         = 10
        calendarView.tintColor                                  = UIColor(red: 0.05, green: 0.14, blue: 0.37, alpha: 1.0)
        let dateSelection                                       = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior                          = dateSelection
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 10),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 150.0)
        ])
    }
}


// MARK: - Calendar View Delegate Methods

extension CalendarController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        isSelected = true
//        let sheet = UIAlertController(title: "Edit", message: "", preferredStyle: .actionSheet)
//        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        sheet.addAction(UIAlertAction(title: "Mark as Done", style: .default, handler: { _ in
//        
//        }))
//        present(sheet, animated: true)
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let day = dateComponents.day else {
            return nil
        }
        if isSelected == true {
            return UICalendarView.Decoration.default(color: .systemBlue, size: .large)
        }
        return nil
    }
}
