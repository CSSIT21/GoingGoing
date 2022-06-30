package party

import "going-going-backend/platform/database/array"

type CheckRequestResponse struct {
	IsRequest bool            `json:"is_request"`
	Type      array.PartyType `json:"type,omitempty"`
}
