import Foundation

protocol DateProvidable {
    var dayOfWeekStartingAtZero: Int { get }
}

class DateProvider: DateProvidable {
    var dayOfWeekStartingAtZero: Int {
        Calendar.current.component(.weekday, from: Date.now) - 1
    }
}
