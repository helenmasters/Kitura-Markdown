/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

import Ccmark
import KituraTemplateEngine

public class KituraMarkdown: TemplateEngine {
    public var fileExtension: String { return "md" }
    public init() {}

    public func render(filePath: String, context: [String: Any]) throws -> String {
        let md = NSData(contentsOfFile: filePath)
        return  md != nil ? KituraMarkdown.render(from: md!) : ""
    }

    public static func render(from: NSData) -> String {
        guard let htmlBytes = cmark_markdown_to_html(UnsafePointer<Int8>(from.bytes), from.length, 0) else { return "" }

        let html = String(utf8String: htmlBytes)

        free(htmlBytes)

        return html ?? ""
    }

    public static func render(from: String) -> String {
        let md = from.data(using: NSUTF8StringEncoding)
        return  md != nil ? KituraMarkdown.render(from: md!) : ""
    }
}