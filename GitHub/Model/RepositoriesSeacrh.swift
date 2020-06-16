//
//  RepositoriesSeacrh.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation

// MARK: - RepositoriesSeacrh
struct RepositoriesSeacrh: StructDecodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [ItemRepositorie]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct ItemRepositorie: Decodable {
    let id, size, stargazersCount, watchersCount, forksCount, openIssuesCount, forks, openIssues, watchers, score: Int?
    let itemPrivate, fork, hasIssues, hasProjects, hasDownloads, hasWiki, hasPages, archived, disabled: Bool?
    let nodeID, name, fullName, htmlURL, itemDescription, url, forksURL, keysURL, collaboratorsURL, teamsURL, hooksURL, issueEventsURL, eventsURL, assigneesURL, branchesURL, tagsURL, blobsURL, gitTagsURL, gitRefsURL, treesURL, statusesURL, languagesURL, stargazersURL, contributorsURL, subscribersURL, subscriptionURL, commitsURL, gitCommitsURL, commentsURL, issueCommentURL, contentsURL, compareURL, mergesURL, archiveURL, downloadsURL, issuesURL, pullsURL, milestonesURL, notificationsURL, labelsURL, releasesURL, deploymentsURL, gitURL, sshURL, cloneURL, svnURL, language, defaultBranch, homepage, createdAt, updatedAt, pushedAt: String?
    let owner: Owner?
    let license: License?

    enum CodingKeys: String, CodingKey {
        case id, name, owner, fork, url, homepage, size, language, archived, disabled, license, forks, watchers, score
        case nodeID = "node_id"
        case fullName = "full_name"
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case itemDescription = "description"
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case openIssues = "open_issues"
        case defaultBranch = "default_branch"
    }
}

// MARK: - License
struct License: Decodable {
    let key, name, spdxID, nodeID: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case key, name, url
        case spdxID = "spdx_id"
        case nodeID = "node_id"
    }
}
